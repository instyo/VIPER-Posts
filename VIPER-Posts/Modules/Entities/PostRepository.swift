//
//  PostRepository.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//

import Foundation

protocol PostRepository {
    func fetchAll() async throws -> [PostItem]
}

final class PostRepositoryImpl: PostRepository {
    static let shared = PostRepositoryImpl()
    private let client = APIClient()
    
    func fetchAll() async throws -> [PostItem] {
        let urlString = "https://jsonplaceholder.typicode.com/postsX"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return try await client.get(request)
    }    
}
