//
//  XKConstants.swift
//  Pods
//
//  Created by kenneth on 2023/6/8.
//

import UIKit
import Foundation

public let XK_Ratio = XKConstants.ratio

public func XKTranslucentTop(_ top: Double = 0) -> Double {
    return XKConstants.navigationAndStatusBarHeight + top
}
public func XKSafeTop(_ top: Double = 0) -> Double {
    return (XKConstants.safeAreaTop == .zero ? XKConstants.navigationAndStatusBarHeight : XKConstants.safeAreaTop) + top
}
public func XKSafeBottom(_ bottom: Double = 0) -> Double {
    return XKConstants.safeAreaBottom + bottom
}

public struct XKConstants {
    
    private static let _safeAreaBottom = is_iphoneX ? 34.0 : 0.0
    private static let _safeAreaTop = is_iphoneX ? 44.0 : 0.0
    
    public static let is_iphoneX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? (Int((UIScreen.main.currentMode?.size.height ?? 0.0)/(UIScreen.main.currentMode?.size.width ?? 0.01) * 100.0) == 216) : false
    
    public static let screenWidth = UIScreen.main.bounds.width
    
    public static let screenHeight = UIScreen.main.bounds.height
    
    public static let ratio = screenWidth / 375.0
    
    public static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    
    public static let navigationBarHeight = 44.0
    
    public static let navigationAndStatusBarHeight = statusBarHeight + navigationBarHeight
    
    public static let tabBarHeight = 48.0
    
    public static let safeAreaInsets: UIEdgeInsets = {
        if let insets = UIViewController.visible()?.view.safeAreaInsets {
            return insets
        }
        return UIEdgeInsets(top: navigationAndStatusBarHeight, left: 0.0, bottom: _safeAreaBottom, right: 0.0)
    }()
    
    public static let safeAreaTop = safeAreaInsets.top
    
    public static let safeAreaBottom = safeAreaInsets.bottom
}

public extension Int {
    public static let invalid = -100086
}
