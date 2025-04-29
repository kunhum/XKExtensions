//
//  UIViewControllerEntension.swift
//  Health
//
//  Created by Nicholas on 2020/4/19.
//  Copyright © 2020 Nicholas. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

public extension UIViewController {

    // MARK: 从storyboard中获取控制器
    @objc static func xk_initFromStoryBoard(storyboardName: String, bundle: Bundle? = nil) -> UIViewController {

        let sb = UIStoryboard(name: storyboardName, bundle: bundle)
        return sb.instantiateViewController(withIdentifier: xk_className)
    }
    // MARK: 从xib中获取控制器，swift
    @objc static func xk_initFromXIB(bundle: Bundle? = nil) -> UIViewController {

        return self.init(nibName: xk_className, bundle: bundle)
    }
    // MARK: 获取退顶层present过来的controller
    @objc func xk_topPresentingViewController(controller: UIViewController) -> UIViewController {

        if let presentingVC = controller.presentingViewController {
            return xk_topPresentingViewController(controller: presentingVC)
        } else {
            return controller
        }
    }
    // MARK: 隐藏导航栏
    @objc func xk_hideNagationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    // MARK: 显示导航栏
    @objc func xk_showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    // MARK: 透明导航栏
    @objc func xk_setClearNavigationBar() {
        navigationController?.setClearNavigationBar()
    }
    // MARK: 重置导航栏
    @objc func xk_resetNavigationBar() {
        navigationController?.resetNavigationBar()
    }

    // MARK: 设置控制器外观
    @objc func xk_setApprance(backgroundColor: UIColor = .white, shadowColor: UIColor = .clear) {
        navigationController?.setApprance(backgroundColor: backgroundColor, shadowColor: shadowColor)
    }

    // MARK: 显示导航栏下的黑线
    func xk_showNavigationBarBlackLine() {
        navigationController?.showNavigationBarBlackLine()
    }
    // MARK: 隐藏导航栏下的黑线
    func xk_hideNavigationBarBlackLine() {
        navigationController?.hideNavigationBarBlackLine()
    }

}

public extension UIViewController {
    class func visible() -> UIViewController? {
        if let vc = getTopFromScene() {
            return vc
        }
        if let controller = UIApplication.shared.delegate?.window??.rootViewController {
            return visible(from: controller)
        }
        return nil
    }
    
    private class func visible(from controller: UIViewController) -> UIViewController {
        if let pController = controller.presentedViewController {
            return visible(from: pController)
        }
        if let controller = controller as? UITabBarController,
           let selectedVC = controller.selectedViewController {
            return visible(from: selectedVC)
        }
        if let navC = controller as? UINavigationController,
           let vc = navC.visibleViewController {
            return visible(from: vc)
        }
        return controller
    }
    
    class func getTopFromScene() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              let rootVC = window.rootViewController else {
            return nil
        }
        
        return getTopFromScene(from: rootVC)
    }

    private class func getTopFromScene(from vc: UIViewController) -> UIViewController {
        if let nav = vc as? UINavigationController {
            return getTopFromScene(from: nav.visibleViewController ?? nav)
        } else if let tab = vc as? UITabBarController {
            return getTopFromScene(from: tab.selectedViewController ?? tab)
        } else if let presented = vc.presentedViewController {
            return getTopFromScene(from: presented)
        } else {
            return vc
        }
    }
    
}

public extension UINavigationController {
    
    /// 导航栏黑线
    var barBlackLine: UIView? {
        return findBlackLine(view: navigationBar)
    }
    
    // MARK: 透明导航栏
    @objc func setClearNavigationBar() {

        guard #available(iOS 13.0, *) else {
            let image = UIImage.init(color: UIColor.white.withAlphaComponent(0.0), size: CGSize(width: 1.0, height: 1.0))
            navigationBar.setBackgroundImage(image, for: .default)
            barBlackLine?.isHidden = true
            return
        }

        setApprance(backgroundColor: .clear)
    }
    // MARK: 重置导航栏
    @objc func resetNavigationBar() {

        guard #available(iOS 13.0, *) else {
            barBlackLine?.isHidden = false
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.barTintColor = UIColor.white
            return
        }

        setApprance(backgroundColor: .white)
    }

    // MARK: 设置控制器外观
    @objc func setApprance(backgroundColor: UIColor = .white, shadowColor: UIColor = .clear, opaque: Bool = true) {

        
        guard #available(iOS 13.0, *) else {
            navigationBar.setBackgroundImage(UIImage(color: backgroundColor, size: CGSize(width: 10, height: 10)), for: .default)
            navigationBar.shadowImage = UIImage(color: shadowColor, size: CGSize(width: 10, height: 10))
            return
        }
        
        let appearance = navigationBar.standardAppearance ?? UINavigationBarAppearance()
        if opaque {
            appearance.configureWithOpaqueBackground()
        }
        appearance.backgroundColor         = backgroundColor
        appearance.shadowColor             = shadowColor
        navigationBar.standardAppearance   = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        guard #available(iOS 15.0, *) else { return }
        navigationBar.compactScrollEdgeAppearance = appearance
    }

    // MARK: 显示导航栏下的黑线
    func showNavigationBarBlackLine() {
        guard navigationBar != nil else {
            return
        }
        barBlackLine?.isHidden = false
    }
    // MARK: 隐藏导航栏下的黑线
    func hideNavigationBarBlackLine() {
        guard navigationBar != nil else {
            return
        }
        barBlackLine?.isHidden = true
    }

    private func findBlackLine(view: UIView) -> UIView? {

        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return view
        }
        for subView in view.subviews {
            let imageView = findBlackLine(view: subView)
            if imageView != nil {
                return imageView
            }
        }
        return nil
    }
    
    func set(titleAttributes: [NSAttributedString.Key: Any], largeAttributes: [NSAttributedString.Key: Any]? = nil, opaque: Bool = true) {
        navigationBar.set(titleAttributes: titleAttributes, largeAttributes: largeAttributes, opaque: opaque)
    }
}

public extension UINavigationBar {
    /// 这个会统一设置
    class func set(titleAttributes: [NSAttributedString.Key: Any], largeAttributes: [NSAttributedString.Key: Any]? = nil, opaque: Bool = true) {
        guard #available(iOS 13.0, *) else {
            UINavigationBar.appearance().titleTextAttributes = titleAttributes
            if let largeAttributes = largeAttributes {
                UINavigationBar.appearance().largeTitleTextAttributes = largeAttributes
            }
            return
        }
        let appearance = UINavigationBarAppearance()
        if opaque {
            appearance.configureWithOpaqueBackground()
        }
        appearance.titleTextAttributes = titleAttributes
        if let largeAttributes = largeAttributes {
            appearance.largeTitleTextAttributes = largeAttributes
        }
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        guard #available(iOS 15.0, *) else { return }
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
    
    func set(titleAttributes: [NSAttributedString.Key: Any], largeAttributes: [NSAttributedString.Key: Any]? = nil, opaque: Bool = true) {
        guard #available(iOS 13.0, *) else {
            titleTextAttributes = titleAttributes
            if let largeAttributes = largeAttributes {
                largeTitleTextAttributes = largeAttributes
            }
            return
        }
        let appearance = standardAppearance ?? UINavigationBarAppearance()
        if opaque {
            appearance.configureWithOpaqueBackground()
        }
        appearance.titleTextAttributes = titleAttributes
        if let largeAttributes = largeAttributes {
            appearance.largeTitleTextAttributes = largeAttributes
        }
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
        guard #available(iOS 15.0, *) else { return }
        compactScrollEdgeAppearance = appearance
    }
    
}
