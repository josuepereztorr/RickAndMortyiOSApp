//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Josue Perez Torres on 4/12/23.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    // ('Alive', 'Dead' or 'unknown')
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown" // unknown can be a keyword on some swift versions
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
