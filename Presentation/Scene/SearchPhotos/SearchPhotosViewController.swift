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

// MARK: - Private setup methods
private extension SearchPhotosViewController {
    
    func setup() {
        
    }
}
