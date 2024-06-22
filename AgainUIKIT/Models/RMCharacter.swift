//
//  RMCharacter.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMGender
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: URL
    let episode: [URL]
    let url: URL
    let created: String
}
