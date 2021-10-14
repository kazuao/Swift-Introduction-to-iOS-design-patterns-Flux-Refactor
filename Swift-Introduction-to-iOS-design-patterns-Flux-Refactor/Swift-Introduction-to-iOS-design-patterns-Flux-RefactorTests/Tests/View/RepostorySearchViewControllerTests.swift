//
//  RepostorySearchViewControllerTests.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import XCTest
import GitHub
import RxSwift
import RxCocoa
@testable import Swift_Introduction_to_iOS_design_patterns_Flux_Refactor

final class RepostorySearchViewControllerTests: XCTestCase {

    private struct Dependency {
        let apiSession = Mock_GitHubApiSession()
        let searchRepositoryDispatcher: SearchRepositoryDispatcher
        let viewController: RepositorySearchViewController
        
        init() {
            let flux = Flux.mock(apiSession: apiSession)
            self.searchRepositoryDispatcher = flux.searchRepositoryDispatcher
            self.viewController = RepositorySearchViewController(flux: flux)
            viewController.loadViewIfNeeded()
        }
    }
    
    private var dependency: Dependency!

    override func setUp() {
        super.setUp()
        
        dependency = Dependency()
    }
    
    func test_reload_data() {
        let tableView: UITableView = dependency.viewController.tableView
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        
        let repositories = [GitHub.Repository.mock(), GitHub.Repository.mock()]
        dependency.searchRepositoryDispatcher.addRepositories.accept(repositories)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), repositories.count)
    }
    
    func test_search_button_clicked() {
        let query = "username"
        
        let expect = expectation(description: "waiting called apiSession.searchUsers")
        let disposable = dependency.apiSession.searchRepositoriesParams
            .subscribe(onNext: { _query, _page in
                XCTAssertEqual(_query, query)
                XCTAssertEqual(_page, 1)
                expect.fulfill()
            })
        
        let searchBar: UISearchBar = dependency.viewController.searchBar
        searchBar.text = query
        searchBar.delegate!.searchBar!(searchBar, textDidChange: query)
        searchBar.delegate!.searchBarSearchButtonClicked!(searchBar)
        
        wait(for: [expect], timeout: 0.1)
        disposable.dispose()
    }
}
