//
//  FlickrAPIErrorEntity.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

struct FlickrAPIErrorEntity: Decodable {
    let code: Int?
    let message: String?
}
