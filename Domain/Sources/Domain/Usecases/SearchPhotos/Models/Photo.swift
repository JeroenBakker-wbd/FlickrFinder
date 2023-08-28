//
//  Photo.swift
//  Domain
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

public struct Photo {
    public init(id: String, title: String, thumbnailURL: URL, imageURL: URL?) {
        self.id = id
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.imageURL = imageURL
    }
    
    public let id: String
    public let title: String
    public let thumbnailURL: URL
    public let imageURL: URL?
}
