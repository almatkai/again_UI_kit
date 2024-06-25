//
//  GetCharactersResponse.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 23.06.2024.
//

import Foundation

struct RMResponse<T: Codable>: Codable {
    let info: RMInfo
    let results: [T]
}

