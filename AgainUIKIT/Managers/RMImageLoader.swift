//
//  ImageLoader.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 02.07.2024.
//

import Foundation

/// Image loader to download images from the network
final class RMImageLoader {
    static let shared = RMImageLoader()
    private var imageCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    ///   Downloads the
    /// - Parameters:
    ///   - url: URL of the image
    ///   - completion: Result with Data or Error
    func downalodImage(_ url: URL, completion: @escaping(Result<Data, Error>)-> Void) {
        
        /// Check if image is already in cache
        if let data = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(data as Data))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, _, error  in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            /// Cache the data for future use
            self?.imageCache
                 .setObject(data as NSData,
                            forKey: url.absoluteString as NSString)
            completion(.success(data))
        })
        task.resume()
    }
}
