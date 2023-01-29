//
//  PhotoEntity.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

struct PhotoEntity: Codable {

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
    
    #if DEBUG
    init(id: String? = nil, owner: String? = nil, secret: String? = nil, server: String? = nil, farm: Int? = nil, title: String? = nil, isPublic: Int? = nil, isFriend: Int? = nil, isFamily: Int? = nil, thumbnailURL: URL? = nil, imageURL: URL? = nil, originalImageURL: URL? = nil) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.isPublic = isPublic
        self.isFriend = isFriend
        self.isFamily = isFamily
        self.thumbnailURL = thumbnailURL
        self.imageURL = imageURL
        self.originalImageURL = originalImageURL
    }
    #endif
}
