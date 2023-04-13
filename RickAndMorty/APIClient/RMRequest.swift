//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/12/23.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    
    
    /// API Constants
    private struct Constant {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    
    /// Path components for API, if any
    private let pathComponents: Set<String>
    
    // build in query name object type
    
    /// Query arguments for API, if any
    private let queryParamters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        
        // "https://rickandmortyapi.com/api/characters"
        var string = Constant.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        
        if !pathComponents.isEmpty {
            pathComponents.forEach { component in
                string += "/\(component)" // or string += "/\($0)"
            }
        }
        
        // "https://rickandmortyapi.com/api/characters/?name=rick&status=alive"
        /* You can also include filters in the URL by including additional query paramters.
         To start filtering add a ? followed by the query <query>=<value>. If you want to chaiin
         several queries in the same call, use & followed by the query. */
        if !queryParamters.isEmpty {
            // add the ? to start the query
            string += "?"
            // compactMap(_:) - returns an array containing the non-nil resutls of calling the given transformation with each elemnt of this sequence
            let argumentString = queryParamters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    // MARK: - Public
    
    // since pathComponents and queryParameters are optional, we are defaulting to a empty array
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParamters: Collection of query paramters
    public init(
        endpoint: RMEndpoint,
        pathComponents: Set<String> = [],
        queryParamters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParamters = queryParamters
    }
    
}
