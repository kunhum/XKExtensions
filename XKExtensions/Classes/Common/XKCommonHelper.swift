//
//  XKCommonHelper.swift
//  XKExtensions
//
//  Created by kenneth on 2023/9/12.
//

import Foundation

struct XKCommonHelper {
    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var screenHeight: CGFloat { UIScreen.main.bounds.height }
    static let safeAreaInsets: UIEdgeInsets = {
        var areaInsets: UIEdgeInsets = .zero
        if #available(iOS 13.0, *),
           let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            areaInsets = window.safeAreaInsets
        } else if #available(iOS 11.0, *),
                  let window = UIApplication.shared.windows.first {
            areaInsets = window.safeAreaInsets
        } else {
            
        }
        return areaInsets
    }()
    static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    static let navigationBarHeight = 44.0
    static let navigationAndStatusBarHeight = statusBarHeight + navigationBarHeight
}
