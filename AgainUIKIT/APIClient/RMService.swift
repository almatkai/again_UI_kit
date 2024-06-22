//
//  RMService.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init() {}
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data and error
    public func execute( _ request: RMRequest,completion: @escaping () -> Void ) {
        
    }
}
