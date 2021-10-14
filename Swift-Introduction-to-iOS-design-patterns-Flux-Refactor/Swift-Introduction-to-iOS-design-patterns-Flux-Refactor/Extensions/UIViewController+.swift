//
//  UIViewController+.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController: ExtensionCompatible {}

extension Extension where Base: UIViewController {
    var viewDidAppear: Observable<Void> {
        return base.rx.methodInvoked(#selector(UIViewController.viewDidAppear(_:)))
            .map { _ in }
    }
    
    var viewDidDisappear: Observable<Void> {
        return base.rx.methodInvoked(#selector(UIViewController.viewDidDisappear(_:)))
            .map { _ in }
    }
}
