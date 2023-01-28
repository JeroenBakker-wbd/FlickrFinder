//
//  SearchPhotosResponseEntity.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

struct SearchPhotosResponseEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
        case photos = "photo"
    }
    
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photos: [PhotoEntity]?
}
