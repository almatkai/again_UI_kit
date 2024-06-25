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
        guard let request = request(from: rmRequest) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _ , error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print("")
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                print("Here is the error")
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

