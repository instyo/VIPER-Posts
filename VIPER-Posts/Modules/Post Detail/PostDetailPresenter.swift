//
//  PostListPresenter.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//

import Foundation
import UIKit

protocol PostDetailPresenterInput {
    func viewDidLoad(id: Int)
}

protocol PostDetailPresenterOutput : AnyObject {
    func showPostDetail(_ post: PostItem)
    func showError(_ message: String)
}

class PostDetailPresenter: PostDetailPresenterInput {
    weak var view: PostDetailPresenterOutput?
    var interactor: PostDetailInteractorInput!
    weak var router: PostDetailRouter?
    
    private var post: PostItem?
    private var errorMessage: String?
    
    func viewDidLoad(id: Int) {
        Task {
            await interactor.loadPostDetail(id: id)
        }
    }
}

extension PostDetailPresenter: PostDetailInteractorOutput {
    func didLoadPostDetail(_ post: PostItem) {
        DispatchQueue.main.async { [weak self] in
            self?.post = post
            self?.view?.showPostDetail(post)
        }
    }
    
    func didFailToLoadPostDetail(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = message
            self?.view?.showError(message)
        }
    }
}
