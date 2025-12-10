//
//  PostListInteractor.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//

import Foundation

protocol PostListInteractorInput {
    func loadPosts() async
}

protocol PostListInteractorOutput : AnyObject {
    func didLoadPosts(_ posts: [PostItem])
    func didLoadPostsError(_ message: String)
}

class PostListInteractor: PostListInteractorInput {
    weak var output: PostListInteractorOutput?
    private let repository: PostRepository
    
    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func loadPosts() async {
        do {
            let posts = try await repository.fetchAll()
            output?.didLoadPosts(posts)
        } catch {
            output?.didLoadPostsError(error.localizedDescription)
        }
    }
}
