//
//  Mock_Flux.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import Foundation
@testable import Swift_Introduction_to_iOS_design_patterns_Flux_Refactor

extension Flux {
    static func mock(apiSession: Mock_GitHubApiSession = .init(),
                     localCache: Mock_LocalCache = .init()) -> Flux
    {
        let searchRepositoryDispatcher = SearchRepositoryDispatcher()
        let searchRepositoryActionCreator = SearchRepositoryActionCreator(dispatcher: searchRepositoryDispatcher,
                                                                          apiSession: apiSession)
        let searchRepositoryStore = SearchRepositoryStore(dispatcher: searchRepositoryDispatcher)

        let selectedRepositoryDispatcher = SelectedRepositoryDispatcher()
        let selectedRepositoryActionCreator = SelectedRepositoryActionCreator(dispatcher: selectedRepositoryDispatcher)
        let selectedRepositoryStore = SelectedRepositoryStore(dispatcher: selectedRepositoryDispatcher)

        let favoriteRepositoryDispatcher = FavoriteRepositoryDispatcher()
        let favoriteRepositoryActionCreator = FavoriteRepositoryActionCreator(dispatcher: favoriteRepositoryDispatcher,
                                                                              localCache: localCache)
        let favoriteRepositoryStore = FavoriteRepositoryStore(dispatcher: favoriteRepositoryDispatcher)

        return Flux(searchRepositoryDispatcher: searchRepositoryDispatcher,
                    searchRepositoryActionCreator: searchRepositoryActionCreator,
                    searchRepositoryStore: searchRepositoryStore,

                    selectedRepositoryDispatcher: selectedRepositoryDispatcher,
                    selectedRepositoryActionCreator: selectedRepositoryActionCreator,
                    selectedRepositoryStore: selectedRepositoryStore,

                    favoriteRepositoryDispatcher: favoriteRepositoryDispatcher,
                    favoriteRepositoryActionCreator: favoriteRepositoryActionCreator,
                    favoriteRepositoryStore: favoriteRepositoryStore)
    }
}
