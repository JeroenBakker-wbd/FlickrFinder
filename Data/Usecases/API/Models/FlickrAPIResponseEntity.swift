//
//  FlickrAPIResponseEntity.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

protocol FlickrAPIResponseEntity: Codable {
    var stat: FlickrAPIResponseStat? { get }
}
