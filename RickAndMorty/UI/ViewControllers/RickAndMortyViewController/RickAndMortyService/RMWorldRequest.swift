//
//  RMWorldRequest.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import Foundation

class RMWorldRequest: APIRequest<RMWorld> {
    var page: Int = 0
    
    var category: RMCategory = .character
    
    override var endPoint: String {
        return category.rawValue
    }
    
    override var requestType: HTTPMethod {
        return .get
    }
    
    override var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }
}
