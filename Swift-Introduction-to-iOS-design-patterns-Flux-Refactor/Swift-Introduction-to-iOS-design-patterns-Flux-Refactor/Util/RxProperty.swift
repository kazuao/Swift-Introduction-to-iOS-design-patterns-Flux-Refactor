//
//  RxProperty.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import RxSwift
import RxRelay

public final class Property<Element> {
    
    // MARK: Type Alias
    public typealias E = Element
    
    
    // MARK: Variable
    private let _behaviorRelay: BehaviorRelay<E>
    
    public var value: E {
        get {
            return _behaviorRelay.value
        }
    }
    
    
    // MARK: Initialize
    public init(_ value: E) {
        _behaviorRelay = BehaviorRelay(value: value)
    }
    
    public init(_ behabiorRelay: BehaviorRelay<E>) {
        _behaviorRelay = behabiorRelay
    }
    
    public convenience init(unsafeObservable: Observable<E>) {
        let observable = unsafeObservable.share(replay: 1, scope: .whileConnected)
        var initial: E? = nil
        
        let initialDisposable = observable
            .subscribe(onNext: { initial = $0 })
        
        guard let _initial = initial else { fatalError() }
        
        self.init(initial: _initial, then: observable)
        
        initialDisposable.dispose()
    }
    
    public init(initial: E, then observable: Observable<E>) {
        _behaviorRelay = BehaviorRelay(value: initial)
        
        _ = observable
            .bind(to: _behaviorRelay)
    }
    
    public func asObservable() -> Observable<E> {
        return _behaviorRelay.asObservable()
    }
    
    public var changed: Observable<E> {
        return asObservable().skip(1)
    }
}
