//
//  APIClient.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//


import Foundation

final class APIClient {
    func get<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse,
              (200...209).contains(http.statusCode) else {
            throw APIError.invalidURL
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}