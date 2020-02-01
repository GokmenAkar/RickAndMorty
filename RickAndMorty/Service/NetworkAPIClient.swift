//
//  NetworkAPIClient.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import Foundation

typealias responseHandle = (APIResponse) -> Void

class NetworkClintAPI {
    func callAPI<ResponseType>(request: APIRequest<ResponseType>, responseHandler: @escaping responseHandle) {
        let urlRequest = urlRequestWith(apiRequest: request)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                responseHandler(.init(success: false, message: error.localizedDescription, data: nil))
                return
            }
            guard let response = response, let data = data else {
                responseHandler(.init(success: false, message: "error", data: nil))
                return
            }
            let apiResponse = self.successResponse(request: request, response: response, data: data)
            responseHandler(apiResponse)
        }.resume()
    }
    
    func urlRequestWith<ResponseType>(apiRequest: APIRequest<ResponseType>) -> URLRequest {
        let completeURL = apiRequest.baseURL  +
                          apiRequest.apiPath  +
                          apiRequest.endPoint
        print(completeURL)
        
        var urlComponents = URLComponents(string: completeURL)!
        
        urlComponents.queryItems = apiRequest.queryItems

        var urlRequest = URLRequest(url: urlComponents.url!)
        
        print(urlComponents.url)

        urlRequest.httpMethod = apiRequest.requestType.rawValue
        urlRequest.setValue(apiRequest.contentType, forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
    func successResponse<ResponseType: Codable>(request:APIRequest<ResponseType>, response: URLResponse, data: Data) -> APIResponse {
        do {
            let responseJSON = try JSONDecoder().decode(ResponseType.self, from: data)
            return APIResponse(success: true, message: "", data: responseJSON as AnyObject)
        } catch {
            return APIResponse(success: false, message: error.localizedDescription)
        }
    }
}
