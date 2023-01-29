//
//  SearchPhotosRouter.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain

protocol SearchPhotosRouter: AnyObject {
    func searchPhotosDidTap(photo: Photo)
}
