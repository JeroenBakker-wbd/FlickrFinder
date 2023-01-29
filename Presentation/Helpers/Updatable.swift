//
//  Updatable.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import Foundation

protocol Updatable {
    associatedtype ViewModel: Equatable
    
    func update(with viewModel: ViewModel?)
}
