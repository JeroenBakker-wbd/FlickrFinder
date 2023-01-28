//
//  PhotoEntity.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

struct PhotoEntity: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
        case thumbnailURL = "url_n"
        case imageURL = "url_l"
        case originalImageURL = "url_o"
    }
    
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let isPublic: Int?
    let isFriend: Int?
    let isFamily: Int?
    let thumbnailURL: URL?
    let imageURL: URL?
    let originalImageURL: URL?
}
