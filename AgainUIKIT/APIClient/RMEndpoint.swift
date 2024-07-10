//
//  RMEndpoint.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import Foundation

/// Representes unique API endpoint
@frozen enum RMEndpoint: String, CaseIterable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get locatio  info
    case location
    /// Endpoint to get episode info
    case episode
}
