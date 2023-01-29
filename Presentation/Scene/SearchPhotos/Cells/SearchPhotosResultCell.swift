//
//  SearchPhotosResultCell.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import UIKit
import Nuke

final class SearchPhotosResultCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: type(of: SearchPhotosResultCell.self))
    
    private lazy var imageView: UIImageView = makeImageView()
    private lazy var titleLabel: UILabel = makeTitleLabel()
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) { 
                self.contentView.backgroundColor = self.isHighlighted ? UIColor.lightGray.withAlphaComponent(0.3) : UIColor.clear
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, we do not want storyboards")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
}

// MARK: - Updatable
extension SearchPhotosResultCell: Updatable {
        
    func update(with viewModel: ViewModel?) {
        if let imageUrl = viewModel?.imageUrl {
            Nuke.loadImage(with: imageUrl, into: imageView)
        } else {
            imageView.image = nil
        }
        
        titleLabel.text = viewModel?.title
    }
}

// MARK: - Private setup methods
private extension SearchPhotosResultCell {
    
    func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 25),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - Views
private extension SearchPhotosResultCell {
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }
}

// MARK: - ViewModel
extension SearchPhotosResultCell {
    
    struct ViewModel: Equatable {
        let uniqueId: String = UUID().uuidString
        let id: String
        let title: String
        let imageUrl: URL
    }
}
