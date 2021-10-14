//
//  Mock_GitHub_Pagination.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub

extension GitHub.Pagination {
    static func mock() -> GitHub.Pagination {
        return GitHub.Pagination(next: nil, last: nil, first: nil, prev: nil)
    }
}
