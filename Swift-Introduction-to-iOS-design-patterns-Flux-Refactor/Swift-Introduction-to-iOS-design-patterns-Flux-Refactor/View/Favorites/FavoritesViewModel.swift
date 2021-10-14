//
//  FavoritesViewModel.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import GitHub
import RxSwift
import RxCocoa

final class FavoritesViewModel {
    
    let favorites: Property<[GitHub.Repository]>
    let reloadFovorites: Observable<Void>
    
    private let _selectedIndexPath = PublishRelay<IndexPath>()
    private let disposeBag = DisposeBag()
    
    init(flux: Flux) {
        let selectedActionCreator = flux.selectedRepositoryActionCreator
        let favoriteStore = flux.favoriteRepositoryStore
        
        self.favorites = favoriteStore.repositories
        self.reloadFovorites = favorites.changed
            .map { _ in }
        
        _selectedIndexPath
            .withLatestFrom(favorites.asObservable()) { $1[$0.row] }
            .subscribe(onNext: { repository in
                selectedActionCreator.setSelectedRepository(repository)
            })
            .disposed(by: disposeBag)
    }
    
    func selectedIndexPath(_ indexPath: IndexPath) {
        _selectedIndexPath.accept(indexPath)
    }
}
