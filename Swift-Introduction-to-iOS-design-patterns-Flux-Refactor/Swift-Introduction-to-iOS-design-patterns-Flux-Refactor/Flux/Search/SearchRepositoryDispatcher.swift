//
//  SearchRepositoryDispatcher.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import GitHub
import RxSwift
import RxCocoa

final class SearchRepositoryDispatcher {
    static let shared = SearchRepositoryDispatcher()
    
    let query = PublishRelay<String?>()
    let addRepositories = PublishRelay<[GitHub.Repository]>()
    let clearRepositories = PublishRelay<Void>()
    let pagination = PublishRelay<GitHub.Pagination?>()
    let isFetching = PublishRelay<Bool>()
    let isSearchFieldEditing = PublishRelay<Bool>()
    let error = PublishRelay<Error>()
}
