//
//  SelectedRepositoryActionCreator.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub
import RxSwift
import RxCocoa

final class SelectedRepositoryActionCreator {

    static let shared = SelectedRepositoryActionCreator()

    private let dispatcher: SelectedRepositoryDispatcher

    init(dispatcher: SelectedRepositoryDispatcher = .shared) {
        self.dispatcher = dispatcher
    }

     func setSelectedRepository(_ repository: GitHub.Repository?) {
        dispatcher.repository.accept(repository)
    }
}
