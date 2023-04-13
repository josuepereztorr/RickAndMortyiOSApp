//
//  RMService.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/12/23.
//

import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init() {}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we except to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMService,
        expecting type: T.Type, // T.Type refers to the the type of T, not an instance of T
        completion: @escaping (Result<T, Error>) -> Void) {
            
        }
}
