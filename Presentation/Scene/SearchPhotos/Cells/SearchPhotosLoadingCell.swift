//
//  SearchPhotosLoadingCell.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import UIKit

final class SearchPhotosLoadingCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: type(of: SearchPhotosLoadingCell.self))
    
    private lazy var imageLoadingView: UIView = makeImageLoadingView()
    private lazy var titleLoadingView: UIView = makeTitleLoadingView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, we do not want storyboards")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.layer.removeAllAnimations()
        contentView.alpha = 1
    }
}

// MARK: - Updatable
extension SearchPhotosLoadingCell: Updatable {
    
    typealias ViewModel = String
    
    func update(with viewModel: ViewModel?) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
            self.contentView.alpha = 0.8
        }
    }
}

// MARK: - Private setup methods
private extension SearchPhotosLoadingCell {
    
    func setup() {
        isUserInteractionEnabled = false
        
        contentView.addSubview(imageLoadingView)
        contentView.addSubview(titleLoadingView)
        
        NSLayoutConstraint.activate([
            imageLoadingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageLoadingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageLoadingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageLoadingView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            
            titleLoadingView.leadingAnchor.constraint(equalTo: imageLoadingView.trailingAnchor, constant: 25),
            titleLoadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLoadingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            titleLoadingView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}

// MARK: - Views
private extension SearchPhotosLoadingCell {
    
    func makeImageLoadingView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.5
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeTitleLoadingView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.5
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
