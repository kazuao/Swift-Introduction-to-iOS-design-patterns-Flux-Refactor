//
//  FavoritesViewController.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import UIKit
import RxSwift

class FavoritesViewController: UIViewController {
    
    // MARK: UI
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Variable
    private let flux: Flux
    private lazy var viewModel = FavoritesViewModel(flux: flux)
    private lazy var dataSource = FavoritesDataSource(
        favorites: viewModel.favorites,
        selectedIndexPath: { [weak viewModel] in
            viewModel?.selectedIndexPath($0) })
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Initialize
    init(flux: Flux = .shared) {
        self.flux = flux
        
        super.init(nibName: "FavoritesViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        
        dataSource.configure(tableView)
        
        viewModel.reloadFovorites
            .bind(to: Binder(tableView) { tableView, _ in
                tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}
