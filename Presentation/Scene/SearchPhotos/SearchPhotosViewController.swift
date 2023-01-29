//
//  SearchPhotosViewController.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import UIKit

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
extension SearchPhotosViewController {
    
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
        case .skeletonLoading, .paginationLoading:
            break // we don't want to do anything
        case .results(let id):
            interactor.handle(request: .didTapItem(id: id))
        }
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
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addGestureRecognizer(makeTapGesture())
    }
}

// MARK: - Views
private extension SearchPhotosViewController {
    
    func makeSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search..." // Would be nice to localize
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
        return collectionView
    }
    
    func makeCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5))
            
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
            
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(250))
            
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            
            return layoutSection
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<SearchPhotosSection, SearchPhotosItem> {
        return .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            //            switch item {
            //            case .paginationLoading(let model):
            //                break
            //            case .results(let model):
            //                break
            //            case .skeletonLoading(let model):
            //                break
            //            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseIdentifier, for: indexPath)
            return cell
        })
    }
    
    func makeTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }
}
