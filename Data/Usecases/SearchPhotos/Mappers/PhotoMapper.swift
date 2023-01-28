//
//  PhotoMapper.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain

struct PhotoMapper: EntityMapable {
    
    func map(entity: PhotoEntity?) -> Photo? {
        guard
            let id = entity?.id,
            let title = entity?.title,
            let thumbnailURL = entity?.thumbnailURL
        else {
            return nil
        }
        
        return Photo(
            id: id,
            title: title,
            thumbnailURL: thumbnailURL,
            imageURL: entity?.imageURL ?? entity?.originalImageURL
        )
    }
}
