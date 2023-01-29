//
//  SearchPhotosViewController.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import UIKit

protocol SearchPhotosDisplayLogic: AnyObject {
    func display(viewModel: SearchPhotosViewController.ViewModel)
    func displayClearResults()
    func displayResult(items: [SearchPhotosItem], isNewResult: Bool)
    func display(isLoading: Bool, item: SearchPhotosItem)
}

final class SearchPhotosViewController: UIViewController {
    
    // MARK: Private properties
    private let interactor: SearchPhotosInteractor
    
    private lazy var searchBar: UISearchBar = makeSearchBar()
    private lazy var collectionView: UICollectionView = makeCollectionView()
    private lazy var dataSource: UICollectionViewDiffableDataSource<SearchPhotosSection, SearchPhotosItem> = makeDataSource()
    
    // MARK: Lifecycle
    required init(interactor: SearchPhotosInteractor) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        interactor.handle(request: .viewDidLoad)
    }
}

// MARK: - Display logic methods
extension SearchPhotosViewController: SearchPhotosDisplayLogic {
    
    func display(viewModel: SearchPhotosViewController.ViewModel) {
        syncSafe {
            searchBar.placeholder = viewModel.searchBarPlaceholder
        }
    }
    
    func displayResult(items: [SearchPhotosItem], isNewResult: Bool) {
        syncSafe {
            var snapshot = dataSource.snapshot()
            if isNewResult {
                snapshot.deleteAllItems()
                snapshot.appendSections([.results])
            }
            snapshot.appendItems(items, toSection: .results)
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func displayClearResults() {
        syncSafe {
            var snapshot = dataSource.snapshot()
            snapshot.deleteAllItems()
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func display(isLoading: Bool, item: SearchPhotosItem) {
        syncSafe {
            var snapshot = dataSource.snapshot()
            if isLoading {
                if snapshot.numberOfSections == 0 {
                    snapshot.appendSections([.results])
                }
                snapshot.appendItems([item], toSection: .results)
            } else {
                snapshot.deleteItems([item])
            }
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchPhotosViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor.handle(request: .searchBarTextDidChange(text: searchText))
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {        
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UICollectionViewDelegate
extension SearchPhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        switch item {
        case .loading, .empty:
            break // we don't want to do anything
        case .results(let viewModel):
            interactor.handle(request: .didTapItem(id: viewModel.id))
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height else {
            return
        }
        
        interactor.handle(request: .didScrollFarEnoughForNextBatch)
    }
}

// MARK: - Actions
private extension SearchPhotosViewController {
    
    @objc func didTapView() {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Private setup methods
private extension SearchPhotosViewController {
    
    func setup() {
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addGestureRecognizer(makeTapGesture())
    }
}

// MARK: - Views
private extension SearchPhotosViewController {
    
    func makeSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .default
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        return searchBar
    }
    
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: makeCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(SearchPhotosLoadingCell.self, forCellWithReuseIdentifier: SearchPhotosLoadingCell.reuseIdentifier)
        collectionView.register(SearchPhotosResultCell.self, forCellWithReuseIdentifier: SearchPhotosResultCell.reuseIdentifier)
        collectionView.register(SearchPhotosTitleCell.self, forCellWithReuseIdentifier: SearchPhotosTitleCell.reuseIdentifier)
        return collectionView
    }
    
    func makeCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/5))
            
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 0)
            
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(250))
            
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            
            return layoutSection
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        layout.configuration = config
        return layout
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<SearchPhotosSection, SearchPhotosItem> {
        return .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .loading(let id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseIdentifier, for: indexPath) as? SearchPhotosLoadingCell else {
                    fatalError("Forgot to register SearchPhotosLoadingCell")
                }
                cell.update(with: id)
                return cell
            case .results(let viewModel):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseIdentifier, for: indexPath) as? SearchPhotosResultCell else {
                    fatalError("Forgot to register SearchPhotosResultCell")
                }
                cell.update(with: viewModel)
                return cell
            case .empty(let viewModel):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseIdentifier, for: indexPath) as? SearchPhotosTitleCell else {
                    fatalError("Forgot to register SearchPhotosTitleCell")
                }
                cell.update(with: viewModel)
                return cell
            }
        })
    }
    
    func makeTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }
}
