//
//  XKScrollViewExtension.swift
//  XKExtensions
//
//  Created by kenneth on 2022/4/21.
//

import Foundation
 
public extension UIScrollView {
    
    func setContentInsetNever() {
        guard #available(iOS 11.0, *) else { return }
        contentInsetAdjustmentBehavior = .never
    }
}
