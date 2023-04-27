//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Josue Perez Torres on 4/12/23.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    /* this is how the API response will look like
        {
            info: {},
            results: [
                        {},{},{}...
                     ]
        }
     */
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}
