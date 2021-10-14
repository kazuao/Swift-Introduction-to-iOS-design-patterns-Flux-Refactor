//
//  Mock_LocalCache.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub
import RxSwift
import RxCocoa
@testable import Swift_Introduction_to_iOS_design_patterns_Flux_Refactor

final class Mock_LocalCache: LocalCacheable {
    let cache = BehaviorRelay<Any?>(value: nil)
    
    subscript<T: LocalCacheGettable & LocalCacheSettable>(key: LocalCacheKey<T>) -> T {
        get {
            return (cache.value as? T) ?? key.defaultValue
        }
        
        set(newValue) {
            cache.accept(newValue)
        }
    }
}
