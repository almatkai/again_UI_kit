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
    let endpoint: RMEndpoint
    
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
    
    convenience init?(url: URL) {
        let stringURL = url.absoluteString
        if !stringURL.contains(Constants.baseUrl) {
            print("RMRequest Error: Invalid URL => Does not fit to base URL")
            return nil
        }
        
        let trimmed = stringURL.replacingOccurrences(of: "\(Constants.baseUrl)", with: "")
        if trimmed.contains ("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                let pathComponent: Set<String> = [components[1]]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, pathComponents: pathComponent)
                    return
                }
            }
        }
        else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components [0]
                let queryItemsString = components[1]
                
                let queryItems = queryItemsString.components(separatedBy: "&").compactMap({
                    let component = $0.components(separatedBy: "=")
                    return URLQueryItem(name: component[0],
                                        value: component[1])
                })
                
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
    static let listEpisodesRequests = RMRequest(endpoint: .episode)
}
