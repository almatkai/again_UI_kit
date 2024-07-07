//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    static let identifier = "RMCharacterInfoCollectionViewCell"
    
    enum `Type` {
        case name
        case status
        case type
        case species
        case gender
        case origin
        case location
        case created
        
        var tittle: String {
            switch self {
            case .name:
                return "Name"
            case .status:
                return "Status"
            case .type:
                return "Type"
            case .species:
                return "Species"
            case .gender:
                return "Gender"
            case .origin:
                return "Origin"
            case .location:
                return "Location"
            case .created:
                return "Created"
            }
        }
    }
    
    var type: `Type`
    var content: String
    var displayContent: String {
        if content.isEmpty {
            return "Unknown"
        }
        
        if type == .created {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = .current
            
            // Parse the date string into a Date object
            if let date = dateFormatter.date(from: content) {
                // Format the Date object into the desired string format
                dateFormatter.dateFormat = "dd MMM yyyy"
                let formattedDate = dateFormatter.string(from: date)
                return formattedDate
            } else {
                return "Wrong date format"
            }
        }
        return content
    }
    
    init( type: Type, content: String) {
        self.content = content
        self.type = type
    }
}
