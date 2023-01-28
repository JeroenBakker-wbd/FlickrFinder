//
//  FlickrAPIResponseEntity.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

protocol FlickrAPIResponseEntity: Decodable {
    var stat: FlickrAPIResponseStat? { get }
}
