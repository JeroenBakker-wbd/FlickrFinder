//
//  SearchPhotosResultMapper.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain
import Factory

struct SearchPhotosResultMapper: EntityMapable {
    
    @Injected(Container.Mappers.photo) private var photoMapper
    
    func map(entity: SearchPhotosResponseEntity?) -> SearchPhotosResult? {
        guard let entity = entity else { return nil }
        
        return SearchPhotosResult(
            offset: entity.page ?? 1, // BE starts at 1
            limit: entity.perpage ?? 0,
            totalPhotos: entity.total ?? 0,
            photos: entity.photos?.compactMap({ photoMapper.map(entity: $0) }) ?? []
        )
    }
}
