//
//  PostDetailInteractor.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//

import Foundation

protocol PostDetailInteractorInput {
    func loadPostDetail(id: Int) async
}

protocol PostDetailInteractorOutput: AnyObject {
    func didLoadPostDetail(_ post: PostItem)
    func didFailToLoadPostDetail(_ message: String)
}

class PostDetailInteractor: PostDetailInteractorInput {
    weak var output: PostDetailInteractorOutput?
    private let repository: PostRepository
    
    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func loadPostDetail(id: Int) async {
        do {
            let post = try await repository.fetchDetail(id: id)
            output?.didLoadPostDetail(post)
        } catch {
            output?.didFailToLoadPostDetail(error.localizedDescription)
        }
    }
}
