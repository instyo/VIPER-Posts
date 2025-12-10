//
//  PostListPresenter.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//
import Foundation
import UIKit

protocol PostListPresenterInput {
    func viewDidLoad()
}

protocol PostListPresenterOutput: AnyObject {
    func showPosts(_ posts: [PostItem])
    func showError(_ message: String)
}

class PostListPresenter: PostListPresenterInput {
    weak var view: PostListPresenterOutput?
    var interactor: PostListInteractorInput!
    weak var router: PostListRouter?
    
    private var posts: [PostItem] = []
    private var errorMessage: String?
    
    func viewDidLoad() {
        Task {
            await interactor.loadPosts()
        }
    }
    
}

extension PostListPresenter: PostListInteractorOutput {
    func didLoadPosts(_ posts: [PostItem]) {
        DispatchQueue.main.async { [weak self] in
            self?.posts = posts
            self?.view?.showPosts(posts)
        }
    }
    
    func didLoadPostsError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = message
            self?.view?.showError(message)
        }
    }
}
