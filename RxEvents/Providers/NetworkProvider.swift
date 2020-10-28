//
//  NetworkProvider.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import Foundation

protocol NetworkProviderProtocol {
    func request(url: String, completionHandler: @escaping (Result<EventsEntity, NetworkingError>) -> Void)
}

final class NetworkProvider: NetworkProviderProtocol {
    
    // MARK: - Methods

    func request(url: String, completionHandler: @escaping (Result<EventsEntity, NetworkingError>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.incorrectURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .formatted(DateFormatter.Formatter)
                let events = try decoder.decode(EventsEntity.self, from: data)
                completionHandler(.success(events))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

