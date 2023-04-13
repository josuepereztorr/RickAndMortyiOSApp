//
//  RMEpisodes.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/10/23.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_Date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
