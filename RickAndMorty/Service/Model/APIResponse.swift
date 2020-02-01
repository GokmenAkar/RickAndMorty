//
//  APIResponse.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import Foundation

struct APIResponse {
    var success: Bool!   // whether the API call passed or failed
    var message: String? // message returned from the API
    var data: AnyObject? // actual data returned from the API

    init(success: Bool, message: String? = nil, data: AnyObject? = nil) {
        self.success = success
        self.message = message
        self.data = data
    }
}
