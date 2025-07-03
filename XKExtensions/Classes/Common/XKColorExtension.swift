//
//  XKColorExtension.swift
//  XKExtensions
//
//  Created by Kenneth Tse on 2025/4/27.
//

import Foundation
import SwifterSwift

public extension UIColor {
    static let firstText: UIColor = UIColor(hexString: "#333333") ?? .black
    static let secondText: UIColor = UIColor(hexString: "#999999") ?? .black
    static let thirdText: UIColor = UIColor(hexString: "#CCCCCC") ?? .black
    static let subText: UIColor = UIColor(hexString: "#666666") ?? .black
    static let colorF5: UIColor = UIColor(hexString: "#F5F5F5") ?? .black
    static let colorE5: UIColor = .init(hexString: "#E5E5E5") ?? .black
    static let xkSeparator: UIColor = .init(hexString: "#EEEEEE") ?? .black
    static let maskColor: UIColor = .black.withAlphaComponent(0.4)
    static let sectionBackground: UIColor = .init(hexString: "#F7F7F7") ?? .lightGray
}
