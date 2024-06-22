//
//  RMLocation.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import Foundation

struct RMLocation: Codable { // Codable for JSON serialization/deserialization
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [URL]  // Array of URLs for characters
    let url: URL
    let created: String   // Consider using Date for time representation

    // Optional Computed Property for convenience:
    var residentsNames: [String] {
        residents.compactMap { $0.lastPathComponent } // Extract names if possible
    }
}
