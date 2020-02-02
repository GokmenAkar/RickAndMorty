//
//  RMWorldService.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import Foundation

typealias serviceHandler = (Bool, RMWorld?, RMEpisode?) -> Void

class RMWorldService {
    var page : Int = 0
    var count: Int = 12
    
    var requesting: Bool = false
    
    func fetchRMData(page: Int, category: RMCategory, completion: @escaping serviceHandler) {
        guard !requesting else { return }
        requesting = true
        self.page += 1
        
        switch category {
        case .episode:
            let request = RMEpisodeRequest()
            request.page     = page
            apiRequest(apiRequest: request, completion: completion)
        default:
            let request = RMWorldRequest()
            request.category = category
            request.page     = page
            apiRequest(apiRequest: request, completion: completion)
        }
        
    }
    
    func apiRequest<T: Codable>(apiRequest: APIRequest<T>, completion: @escaping serviceHandler) {
        NetworkClintAPI().callAPI(request: apiRequest) { [weak self] (response) in
            self?.requesting = false
            if response.success {
                if let rmWorld = response.data as? RMWorld {
                    completion(true, rmWorld, nil)
                } else if let rmEpisode = response.data as? RMEpisode {
                    completion(true, nil, rmEpisode)
                } else {
                    print("olmadi")
                }
            } else {
                print("Hata", response.message ?? "Bilinmeyen hata")
            }
        }
    }
}
