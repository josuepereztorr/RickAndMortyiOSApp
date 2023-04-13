//
//  RMCharacterGender.swift
//  RickAndMorty
//
//  Created by Josue Perez Torres on 4/12/23.
//

import Foundation

enum RMCharacterGender: String, Codable {
    // ('Female', 'Male', 'Genderless' or 'unknown')
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}
