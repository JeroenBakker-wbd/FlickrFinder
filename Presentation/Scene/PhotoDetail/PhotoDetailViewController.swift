//
//  PhotoDetailViewController.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import UIKit
import Nuke

protocol PhotoDetailDisplayLogic: AnyObject {
    func display(viewModel: PhotoDetailViewController.ViewModel)
}

final class PhotoDetailViewController: UIViewController {
    
    // MARK: Private properties
    private let interactor: PhotoDetailInteractor
    
    private lazy var imageView: UIImageView = makeImageView()
    
    // MARK: Lifecycle
    required init(interactor: PhotoDetailInteractor) {
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
extension PhotoDetailViewController: PhotoDetailDisplayLogic {
    
    func display(viewModel: PhotoDetailViewController.ViewModel) {
        syncSafe {
            Nuke.loadImage(with: viewModel.imageURL, into: imageView)
        }
    }
}

// MARK: - Private setup methods
private extension PhotoDetailViewController {
    
    func setup() {
        view.backgroundColor = .black
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Views
private extension PhotoDetailViewController {
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
