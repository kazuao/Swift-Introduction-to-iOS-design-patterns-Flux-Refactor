//
//  Mock_GitHubApiSession.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub
import RxSwift
import RxCocoa
@testable import Swift_Introduction_to_iOS_design_patterns_Flux_Refactor

final class Mock_GitHubApiSession: GitHubApiRequestable {
    
    let searchRepositoriesParams: Observable<(String, Int)>
    private let _searchRepositoriesParams = PublishRelay<(String, Int)>()
    private let _searchRepositoriesResult = PublishRelay<([GitHub.Repository], GitHub.Pagination)>()
    
    init() {
        self.searchRepositoriesParams = _searchRepositoriesParams.asObservable()
    }
    
    func searchRepositories(query: String, page: Int) -> Observable<([Repository], Pagination)> {
        _searchRepositoriesParams.accept((query, page))
        return _searchRepositoriesResult.asObservable()
    }
    
    func setSearchRepositoriesResult(repositories: [GitHub.Repository], pagination: GitHub.Pagination) {
        _searchRepositoriesResult.accept((repositories, pagination))
    }
}
