//
//  XKConstants.swift
//  Pods
//
//  Created by kenneth on 2023/6/8.
//

import UIKit
import Foundation

public let XK_Ratio = XKConstants.ratio

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
        var areaInsets: UIEdgeInsets = .zero
        if #available(iOS 13.0, *),
           let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            areaInsets = window.safeAreaInsets
        } else if #available(iOS 11.0, *),
                  let window = UIApplication.shared.windows.first {
            areaInsets = window.safeAreaInsets
        } else {
            areaInsets = UIEdgeInsets(top: _safeAreaTop, left: 0.0, bottom: _safeAreaBottom, right: 0.0)
        }
        return areaInsets
    }()
    
    public static let safeAreaTop = safeAreaInsets.top
    
    public static let safeAreaBottom = safeAreaInsets.bottom
}
