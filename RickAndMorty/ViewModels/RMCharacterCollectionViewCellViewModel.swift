//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/18/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    
    let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    // we are using a model for characterStatus but our view (RMCharacterCollectionViewCell) only cares about the "raw" string
    public var characterStatusText: String {
        // returns a String ex. "Alive"
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        // TODO: - Abstract to Image Manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
