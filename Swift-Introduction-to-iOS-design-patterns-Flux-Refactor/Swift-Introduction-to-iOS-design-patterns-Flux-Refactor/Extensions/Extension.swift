//
//  Extension.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import Foundation

protocol ExtensionCompatible {
    associatedtype ExtensionCompatibleType
    static var `extension`: Extension<ExtensionCompatibleType>.Type { get }
    var `extension`: Extension<ExtensionCompatibleType> { get }
}

extension ExtensionCompatible {
    static var `extension`: Extension<Self>.Type {
        return Extension<Self>.self
    }
    
    var `extension`: Extension<Self> {
        return Extension<Self>(base: self)
    }
}

struct Extension<Base> {
    let base: Base
}
