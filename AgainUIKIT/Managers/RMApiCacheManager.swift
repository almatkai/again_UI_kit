//
//  RMApiCacheManager.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 08.07.2024.
//

import Foundation

/// Cache manager for API data
final class RMApiCacheManager {
    
    // API URL : Data
    private var cache = NSCache<NSString, NSData>()
    
    public func cacheData(for url: URL?, data: Data) {
        guard let url = url else { return }
        cache.setObject(
            data as NSData,
            forKey: url.absoluteString as NSString)
    }
    
    public func getCachedData(for url: URL?) -> Data? {
        guard let url = url else { return nil }
        return cache.object(
            forKey: url.absoluteString as NSString) as Data?
    }
}
