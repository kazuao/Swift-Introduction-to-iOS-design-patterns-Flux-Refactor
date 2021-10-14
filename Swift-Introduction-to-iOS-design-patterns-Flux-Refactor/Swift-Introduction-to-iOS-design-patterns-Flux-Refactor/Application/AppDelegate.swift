//
//  AppDelegate.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private lazy var handler = _AppDelegate(window: window)
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        return handler.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

protocol ApplicationProtocol {}

extension UIApplication: ApplicationProtocol {}

final class _AppDelegate {
    
    // MARK: Variable
    private let window: UIWindow?
    private let flux: Flux
    
    
    // MARK: Initialize
    init(window: UIWindow?, flux: Flux = .shared) {
        self.window = window
        self.flux = flux
    }
    
    private lazy var showRepositoryDetailDisposable: Disposable = {
        return flux.selectedRepositoryStore.repository
            .asObservable()
            .flatMap { $0 == nil ? .empty() : Observable.just(()) }
            .bind(to: Binder(self) { _self, _ in
                guard let tabBarController = _self.window?.rootViewController as? UITabBarController,
                      let navigationController = tabBarController.selectedViewController as? UINavigationController
                else { return }
                
                let vc = RepositoryDetailViewController()
                navigationController.pushViewController(vc, animated: true)
            })
    }()
    
    func application(_ application: ApplicationProtocol,
                     didFinishLaunchingWithOptions launchOprions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        if let tabBarController = window?.rootViewController as? UITabBarController {
            let values: [(UINavigationController, UITabBarItem.SystemItem)] = [
                (UINavigationController(rootViewController: RepositorySearchViewController()), .search),
                (UINavigationController(rootViewController: FavoritesViewController()), .favorites)
            ]
            
            values.enumerated().forEach {
                $0.element.0.tabBarItem = UITabBarItem(tabBarSystemItem: $0.element.1, tag: $0.offset)
            }
            tabBarController.setViewControllers(values.map { $0.0 }, animated: false)
            
            _ = showRepositoryDetailDisposable
            flux.favoriteRepositoryActionCreator.loadFavoriteRepositories()
        }
        
        return true
    }
}

