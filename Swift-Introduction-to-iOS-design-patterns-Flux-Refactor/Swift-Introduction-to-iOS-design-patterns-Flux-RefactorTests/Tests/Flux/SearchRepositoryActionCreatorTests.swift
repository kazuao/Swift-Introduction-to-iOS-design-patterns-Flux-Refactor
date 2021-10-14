//
//  SearchRepositoryActionCreatorTests.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import XCTest
import GitHub
import RxSwift
@testable import Swift_Introduction_to_iOS_design_patterns_Flux_Refactor

class SearchRepositoryActionCreatorTests: XCTestCase {
    
    private struct Dependency {
        let apiSession = Mock_GitHubApiSession()
        
        let actionCreator: SearchRepositoryActionCreator
        let dispather: SearchRepositoryDispatcher
        
        init() {
            let flux = Flux.mock(apiSession: apiSession)
            
            self.actionCreator = flux.searchRepositoryActionCreator
            self.dispather = flux.searchRepositoryDispatcher
        }
    }
    
    private var dependency: Dependency!
    
    override func setUp() {
        super.setUp()
        
        dependency = Dependency()
    }
    
    func test_search_repositories() {
        let repositories: [GitHub.Repository] = [.mock()]
        let pagination = GitHub.Pagination.mock()
        
        let expect = expectation(description: "waiting dispatcher.addRepositories")
        let disposable = dependency.dispather.addRepositories
            .subscribe(onNext: { _repositories in
                XCTAssertEqual(_repositories.count, repositories.count)
                XCTAssertNotNil(_repositories.first)
                XCTAssertEqual(_repositories.first?.fullName, repositories.first?.fullName)
                expect.fulfill()
            })
        
        dependency.actionCreator.searchRepositories(query: "repository-name")
        dependency.apiSession.setSearchRepositoriesResult(repositories: repositories, pagination: pagination)
        
        wait(for: [expect], timeout: 0.1)
        disposable.dispose()
    }
    
    func test_clear_user() {
        let expect = expectation(description: "waiting dispatcher.clearRepositories")
        let disposable = dependency.dispather.clearRepositories
            .subscribe(onNext: {
                expect.fulfill()
            })
        
        dependency.actionCreator.clearRepositories()
        wait(for: [expect], timeout: 0.1)
        
        disposable.dispose()
    }
}
