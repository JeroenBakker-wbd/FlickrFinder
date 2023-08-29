//
//  EntityMapable.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

protocol EntityMapable {
    associatedtype Entity: Decodable
    associatedtype Response
    
    func map(entity: Entity?) -> Response?
}
