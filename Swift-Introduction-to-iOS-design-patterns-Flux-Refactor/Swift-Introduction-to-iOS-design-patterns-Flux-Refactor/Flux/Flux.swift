//
//  Flux.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

final class Flux {
    static let shared = Flux()
    
    // MARK: Search
    let searchRepositoryDispatcher: SearchRepositoryDispatcher
    let searchRepositoryActionCreator: SearchRepositoryActionCreator
    let searchRepositoryStore: SearchRepositoryStore
    
    // MARK: Slected
    let selectedRepositoryDispatcher: SelectedRepositoryDispatcher
    let selectedRepositoryActionCreator: SelectedRepositoryActionCreator
    let selectedRepositoryStore: SelectedRepositoryStore

    // MARK: Fovorites
    let favoriteRepositoryDispatcher: FavoriteRepositoryDispatcher
    let favoriteRepositoryActionCreator: FavoriteRepositoryActionCreator
    let favoriteRepositoryStore: FavoriteRepositoryStore

    init(searchRepositoryDispatcher: SearchRepositoryDispatcher = .shared,
         searchRepositoryActionCreator: SearchRepositoryActionCreator = .shared,
         searchRepositoryStore: SearchRepositoryStore = .shared,
         selectedRepositoryDispatcher: SelectedRepositoryDispatcher = .shared,
         selectedRepositoryActionCreator: SelectedRepositoryActionCreator = .shared,
         selectedRepositoryStore: SelectedRepositoryStore = .shared,
         favoriteRepositoryDispatcher: FavoriteRepositoryDispatcher = .shared,
         favoriteRepositoryActionCreator: FavoriteRepositoryActionCreator = .shared,
         favoriteRepositoryStore: FavoriteRepositoryStore = .shared)
    {
        self.searchRepositoryDispatcher = searchRepositoryDispatcher
        self.searchRepositoryActionCreator = searchRepositoryActionCreator
        self.searchRepositoryStore = searchRepositoryStore

        self.selectedRepositoryDispatcher = selectedRepositoryDispatcher
        self.selectedRepositoryActionCreator = selectedRepositoryActionCreator
        self.selectedRepositoryStore = selectedRepositoryStore

        self.favoriteRepositoryDispatcher = favoriteRepositoryDispatcher
        self.favoriteRepositoryActionCreator = favoriteRepositoryActionCreator
        self.favoriteRepositoryStore = favoriteRepositoryStore
    }
}
