//
//  RepositorySearchViewController.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import UIKit
import RxSwift

class RepositorySearchViewController: UIViewController {
    
    // MARK: UI
    @IBOutlet private(set) weak var searchBar: UISearchBar!
    @IBOutlet private(set) weak var tableView: UITableView!
    
    
    // MARK: Variable
    private let flux: Flux
    private lazy var viewModel = RepositorySearchViewModel(searchText: searchBar.rx.text.asObservable(),
                                                           cancelButtonClicked: searchBar.rx.cancelButtonClicked.asObservable(),
                                                           textDidBeginEditing: searchBar.rx.textDidBeginEditing.asObservable(),
                                                           searchButtonClicked: searchBar.rx.searchButtonClicked.asObservable(),
                                                           flux: flux)
    
    private lazy var dataSource
        = RepositorySearchDataSource(repositories: viewModel.repositories,
                                     selectedIndexPath: { [weak viewModel] in viewModel?._selectedIndexPath($0) },
                                     reachBottom: { [weak viewModel] in viewModel?.reachBottom() })
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Initialize
    init(flux: Flux = .shared) {
        self.flux = flux
        super.init(nibName: "RepositorySearchViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Repositories"
        
        dataSource.configure(tableView)
        
        setupBind()
    }
}


// MARK: Setup
private extension RepositorySearchViewController {
    func setupBind() {
        viewModel.reloadRepositories
            .bind(to: Binder(tableView) { tableView, _ in
                tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.editingLayout
            .bind(to: Binder(self) { _self, _ in
                UIView.animate(withDuration: 0.3) {
                    _self.view.backgroundColor = .black
                    _self.tableView.isUserInteractionEnabled = false
                    _self.tableView.alpha = 0.5
                    _self.searchBar.setShowsCancelButton(true, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.nonEditingLayout
            .bind(to: Binder(self) { _self, _ in
                UIView.animate(withDuration: 0.3) {
                    _self.searchBar.resignFirstResponder()
                    _self.view.backgroundColor = .white
                    _self.tableView.isUserInteractionEnabled = true
                    _self.tableView.alpha = 1
                    _self.searchBar.setShowsCancelButton(false, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
