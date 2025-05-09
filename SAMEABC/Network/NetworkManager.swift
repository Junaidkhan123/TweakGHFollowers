//
//  NetworkManager.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 04/04/2025.
//

import Foundation
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case unknownError
}

let baseURL = "https://api.github.com/users/"

protocol NetWorkManagerProtocol {
    func getFollowers(for username: String, page: Int) async -> Result<[Follower], NetworkError>
}

class NetworkManager: NetWorkManagerProtocol {
    func getFollowers(for username: String, page: Int = 1) async -> Result<[Follower], NetworkError> {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(.invalidResponse)
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                return .success(followers)
            } catch {
                return .failure(.decodingError)
            }
            
        } catch {
            return .failure(.unknownError)
        }
    }
}
