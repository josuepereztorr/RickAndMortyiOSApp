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
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case FailedToGetData
    }
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we except to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest,
        expecting type: T.Type, // T.Type refers to the the type of T, not an instance of T
        completion: @escaping (Result<T, Error>) -> Void) {
        
            // if the .success asign to urlRequest, otherqise return a custom failure
            guard let urlRequest = self.request(from: request) else {
                completion(.failure(RMServiceError.failedToCreateRequest))
                return
            }
        
            let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error ?? RMServiceError.FailedToGetData))
                    return
                }
                
                // Decode the response
                do {
                    let result = try JSONDecoder().decode(type.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    
    // MARK: - Private
    // Converts the URL object from RMRequest into a URLRequest
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        // url can be nil so we must check and unwrap
        guard let url = rmRequest.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}
