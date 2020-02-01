//
//  APIRequest.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import Foundation

class APIRequest<ResponseType:Codable> {
    
    var baseURL: String {
        get {
            return "https://rickandmortyapi.com/"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil 
    }
    
    var apiPath: String {
        return "api/"
    }
    
    var endPoint: String {
        return ""
    }
    
    var requestType: HTTPMethod {
        return .get 
    }
    
    var contentType: String {
        return "application/json"
    }
}
