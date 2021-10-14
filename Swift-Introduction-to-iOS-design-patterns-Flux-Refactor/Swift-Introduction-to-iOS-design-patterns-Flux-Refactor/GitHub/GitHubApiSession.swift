//
//  GitHubApiSession.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import GitHub
import RxSwift

protocol GitHubApiRequestable: AnyObject {
    func searchRepositories(query: String, page: Int) -> Observable<([GitHub.Repository], GitHub.Pagination)>
}

final class GitHubApiSession: GitHubApiRequestable {
    static let shared = GitHubApiSession()
    
    private let session = GitHub.Session()

    func searchRepositories(query: String, page: Int) -> Observable<([Repository], Pagination)> {
        return Single.create { [session] event in
            let request = SearchRepositoriesRequest(query: query, sort: .stars, order: .desc, page: page, perPage: nil)
            let task = session.send(request) { result in
                switch result {
                case let .success((response, pagination)):
                    event(.success((response.items, pagination)))
                case let .failure(error):
                    event(.failure(error))
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
        .asObservable()
    }
}
