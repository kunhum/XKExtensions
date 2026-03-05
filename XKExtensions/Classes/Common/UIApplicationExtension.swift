//
//  UIApplicationExtension.swift
//  XKExtensions
//
//  Created by Kenneth Tse on 2026/3/5.
//

import Foundation
 
public extension UIApplication {
    static func fetchKeywindow() -> UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })
    }
}
