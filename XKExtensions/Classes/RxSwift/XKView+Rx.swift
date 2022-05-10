//
//  XKView+Rx.swift
//  XKExtensions
//
//  Created by kenneth on 2022/5/10.
//

import Foundation
import RxSwift
import RxCocoa

public extension Reactive where Base: UIView {
    var hidden: Observable<Bool> {
        return methodInvoked(#selector(setter: base.isHidden)).map { events -> Bool in
            guard let result = events.first as? Bool else { return false }
            return result
        }
        .startWith(base.isHidden)
    }
}
