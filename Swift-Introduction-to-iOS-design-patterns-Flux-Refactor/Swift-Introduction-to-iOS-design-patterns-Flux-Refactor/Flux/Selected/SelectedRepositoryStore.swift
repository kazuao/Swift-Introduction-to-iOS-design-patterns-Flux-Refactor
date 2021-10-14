//
//  SelectedRepositoryStore.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub
import RxCocoa
import RxSwift

final class SelectedRepositoryStore {
    static let shared = SelectedRepositoryStore()

    let repository: Property<GitHub.Repository?>
    private let _repository = BehaviorRelay<GitHub.Repository?>(value: nil)

    private let disposeBag = DisposeBag()

    init(dispatcher: SelectedRepositoryDispatcher = .shared) {
        self.repository = Property(_repository)

        dispatcher.repository
            .bind(to: _repository)
            .disposed(by: disposeBag)
    }
}
