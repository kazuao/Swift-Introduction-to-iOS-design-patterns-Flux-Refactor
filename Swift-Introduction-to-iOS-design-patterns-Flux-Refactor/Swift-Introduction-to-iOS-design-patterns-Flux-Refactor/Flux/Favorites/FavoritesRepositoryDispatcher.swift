//
//  FavoritesRepositoryDispatcher.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub
import RxCocoa
import RxSwift

final class FavoriteRepositoryDispatcher {
    static let shared = FavoriteRepositoryDispatcher()

    let repositories = PublishRelay<[GitHub.Repository]>()
}

