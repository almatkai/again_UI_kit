//
//  RMRequest.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import Foundation

/// Object that represents single API call
final class RMRequest {
    
    /// API constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api/"
    }
    
    /// Desired Endpoint
    private let endpoint: RMEndpoint

    /// Path components for API if any
    private let pathComponents: Set<String>
    
    /// Query parameters if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url string for API request
    private var urlString: String {
        var string = Constants.baseUrl
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        if !queryParameters.isEmpty {
            string += "?"
            let queryString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += queryString
        }
        
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        print(urlString)
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    /// Construct Request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path Components
    ///   - queryParameters: Collection of Query Parameters
    init(endpoint: RMEndpoint, pathComponents: Set<String> = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
    static let listEpisodesRequests = RMRequest(endpoint: .episode)
}
