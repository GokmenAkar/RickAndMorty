//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 2.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import Foundation

struct RMEpisode: Codable {
    let info: Info?
    let results: [RMEpisdoseResult]
}

// MARK: - Result
struct RMEpisdoseResult: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

