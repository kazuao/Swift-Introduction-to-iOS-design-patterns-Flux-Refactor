//
//  GitHub.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import GitHub

extension Result {
    var element: T? {
        if case let .success(element) = self {
            return element
        } else {
            return nil
        }
    }

    var error: Error? {
        if case let .failure(error) = self {
            return error
        } else {
            return nil
        }
    }
}
