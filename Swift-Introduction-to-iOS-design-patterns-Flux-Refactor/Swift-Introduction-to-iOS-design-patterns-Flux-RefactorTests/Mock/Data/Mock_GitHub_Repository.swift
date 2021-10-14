//
//  Mock_GitHub_Repository.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub

extension GitHub.Repository {
    static func mock() -> GitHub.Repository {
        return GitHub.Repository(id: 1,
                                 nodeID: "nodeID",
                                 name: "URLEmbeddedView",
                                 fullName: "marty-suzuki/URLEmbeddedView",
                                 owner: .mock(),
                                 isPrivate: false,
                                 htmlURL: URL(string: "https://github.com/marty-suzuki/URLEmbeddedView")!,
                                 contributorsURL: URL(string: "https://github.com/marty-suzuki/URLEmbeddedView")!,
                                 description: "URLEmbeddedView automatically caches the object that is confirmed the Open Graph Protocol.",
                                 isFork: false,
                                 url: URL(string: "https://github.com/marty-suzuki/URLEmbeddedView")!,
                                 createdAt: "2016-03-06T03:45:39Z",
                                 updatedAt: "2018-08-28T04:50:22Z",
                                 pushedAt: "2018-07-18T10:04:10Z",
                                 homepage: nil,
                                 size: 1,
                                 stargazersCount: 479,
                                 watchersCount: 479,
                                 language: "Swift",
                                 forksCount: 52,
                                 openIssuesCount: 0,
                                 defaultBranch: "master")
    }
}
