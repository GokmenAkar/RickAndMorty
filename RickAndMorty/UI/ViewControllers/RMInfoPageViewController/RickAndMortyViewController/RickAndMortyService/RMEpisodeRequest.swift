//
//  RMEpisodeRequest.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 2.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import Foundation

class RMEpisodeRequest: APIRequest<RMEpisode> {
    var page: Int = 0
    var category: RMCategory = .episode
    
    override var endPoint: String {
        return category.rawValue
    }
    
    override var requestType: HTTPMethod {
        return .get
    }
    
    override var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "page", value: page.description)
        ]
    }
}
