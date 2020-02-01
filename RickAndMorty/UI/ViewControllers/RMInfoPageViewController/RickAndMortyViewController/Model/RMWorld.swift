//
//  RMWorld.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct RMWorld: Codable {
    let info: Info?
    let results: [RMWorldResult]
}

// MARK: - Result
struct RMWorldResult: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: String?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let url: String?
    let created: String?
    
    //For Location
    let dimension: String?
    let residents: [String]?
    
    //For Episode
    let air_date: String?
    
}


// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next, prev: String?
}


enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
