//
//  FavoritesRepositoryStore.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub
import RxCocoa
import RxSwift

final class FavoriteRepositoryStore {
    static let shared = FavoriteRepositoryStore()

    let repositories: Property<[GitHub.Repository] >
    private let _repositories = BehaviorRelay<[GitHub.Repository] >(value: [])

    private let disposeBag = DisposeBag()

    init(dispatcher: FavoriteRepositoryDispatcher = .shared) {
        self.repositories = Property(_repositories)

        dispatcher.repositories
            .bind(to: _repositories)
            .disposed(by: disposeBag)
    }
}
