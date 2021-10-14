//
//  RepositorySearchViewModelTests.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import XCTest
import GitHub
import RxSwift
import RxCocoa
@testable import Swift_Introduction_to_iOS_design_patterns_Flux_Refactor

class RepositorySearchViewModelTests: XCTestCase {

    private struct Dependency {
        let apiSession = Mock_GitHubApiSession()
        
        let searchStore: SearchRepositoryStore
        let searchDispatcher: SearchRepositoryDispatcher
        let searchActionCreator: SearchRepositoryActionCreator
        
        let selectedStore: SelectedRepositoryStore
        let selectedDispatcher: SelectedRepositoryDispatcher
        let selectedActionCreator: SelectedRepositoryActionCreator

        let viewModel: RepositorySearchViewModel

        let searchText = PublishRelay<String?>()
        let cancelButtonClicked = PublishRelay<Void>()
        let textDidBeginEditing = PublishRelay<Void>()
        let searchButtonClicked = PublishRelay<Void>()
    
        init() {
            let flux = Flux.mock(apiSession: apiSession)

            self.searchStore = flux.searchRepositoryStore
            self.searchDispatcher = flux.searchRepositoryDispatcher
            self.searchActionCreator = flux.searchRepositoryActionCreator

            self.selectedStore = flux.selectedRepositoryStore
            self.selectedDispatcher = flux.selectedRepositoryDispatcher
            self.selectedActionCreator = flux.selectedRepositoryActionCreator

            self.viewModel = RepositorySearchViewModel(searchText: searchText.asObservable(),
                                                       cancelButtonClicked: cancelButtonClicked.asObservable(),
                                                       textDidBeginEditing: textDidBeginEditing.asObservable(),
                                                       searchButtonClicked: searchButtonClicked.asObservable(),
                                                       flux: flux)
        }
    }
    
    private var dependency: Dependency!
    
    override func setUp() {
        super.setUp()
        
        dependency = Dependency()
    }
    
    func test_search_repositories() {
        let query = "repository-name"
        
        let expect = expectation(description: "waiting apiSession.searchRepositoriesParams")
        let disposable = dependency.apiSession.searchRepositoriesParams
            .subscribe(onNext: { _query, _page in
                XCTAssertEqual(_query, query)
                XCTAssertEqual(_page, 1)
                expect.fulfill()
            })
        
        dependency.searchText.accept(query)
        dependency.searchButtonClicked.accept(())
        wait(for: [expect], timeout: 0.1)
        
        disposable.dispose()
    }
    
    func test_reload_data_and_repositories() {
        XCTAssertTrue(dependency.viewModel.repositories.value.isEmpty)
        
        let repositories: [GitHub.Repository] = [.mock(), .mock()]
        
        let expect = expectation(description: "waiting viewModel.reloadData")
        let disposable = dependency.viewModel.reloadRepositories
            .subscribe(onNext: {
                expect.fulfill()
            })

        dependency.searchDispatcher.addRepositories.accept(repositories)
        wait(for: [expect], timeout: 0.1)
        disposable.dispose()

        XCTAssertEqual(dependency.viewModel.repositories.value.count, repositories.count)
        XCTAssertNotNil(dependency.viewModel.repositories.value.first)
        XCTAssertEqual(dependency.viewModel.repositories.value.first?.fullName, repositories.first?.fullName)
    }
}
