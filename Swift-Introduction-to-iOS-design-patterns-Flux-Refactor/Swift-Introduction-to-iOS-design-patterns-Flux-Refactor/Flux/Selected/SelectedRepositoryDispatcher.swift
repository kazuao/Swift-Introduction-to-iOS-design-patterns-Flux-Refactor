//
//  SelectedRepositoryDispatcher.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub
import RxCocoa
import RxSwift

final class SelectedRepositoryDispatcher {
    static let shared = SelectedRepositoryDispatcher()

    let repository = PublishRelay<GitHub.Repository?>()
}
