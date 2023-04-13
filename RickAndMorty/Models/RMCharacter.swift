//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/10/23.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: String
    let species: RMCharacterStatus
    let type: String
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
