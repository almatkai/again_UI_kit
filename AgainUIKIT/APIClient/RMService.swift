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
    
    /// Cache manager for API data
    private let cacheManager = RMApiCacheManager()
    
    /// Privatized constructor
    private init() {}
    
    private enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of an object that we are expecting
    ///   - completion: Callback with data and error
    public func execute<T: Codable>( _ rmRequest: RMRequest,
                             expecting type: T.Type,
                                     completion: @escaping (Result<T, Error>) -> Void ) {
        
        if let data = cacheManager.getCachedData(
                for: rmRequest.url) {
            print("Returning cached data")
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        guard let request = request(from: rmRequest) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, _ , error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                DispatchQueue.global(qos: .background).async {
                    self?.cacheManager.cacheData(
                        for: request.url,
                        data: data)
                }
                completion(.success(result))
            } catch { 
                print("Error in RMService: \(error.localizedDescription)")
                completion(.failure(error))
            }
        })
        task.resume()
    }
    
    // MARK: - Private
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}

