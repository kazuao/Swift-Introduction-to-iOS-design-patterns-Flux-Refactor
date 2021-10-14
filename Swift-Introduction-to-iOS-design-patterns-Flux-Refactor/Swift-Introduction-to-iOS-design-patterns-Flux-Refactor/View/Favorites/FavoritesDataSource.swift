//
//  FavoritesDataSource.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import UIKit
import GitHub

final class FavoritesDataSource: NSObject {
    
    // MARK: UI
    private let favorites: Property<[GitHub.Repository]>
    private let selectedIndexPath: (IndexPath) -> ()
    
    
    // MARK: Initialize
    init(favorites: Property<[GitHub.Repository]>, selectedIndexPath: @escaping (IndexPath) -> ()) {
        self.favorites = favorites
        self.selectedIndexPath = selectedIndexPath
        
        super.init()
    }
    
    
    // MARK: Public
    func configure(_ tableView: UITableView) {
        tableView.register(GitHub.RepositoryCell.nib, forCellReuseIdentifier: GitHub.RepositoryCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}


// MARK: - UITableViewDataSource
extension FavoritesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GitHub.RepositoryCell.identifier, for: indexPath)

        if let repositoryCell = cell as? GitHub.RepositoryCell {
            let repository = favorites.value[indexPath.row]
            repositoryCell.configure(with: repository)
        }

        return cell
    }
}


// MARK: - UITableViewDelegate
extension FavoritesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedIndexPath(indexPath)
    }
}
