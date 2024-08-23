//
//  XKLabelExtension.swift
//  XKExtensions
//
//  Created by Kenneth Tse on 2024/8/21.
//

import Foundation
import SwifterSwift

public extension UILabel {
    convenience init(text: String = "--",
                     font: UIFont = .xk_pingFangSC(size: 15),
                     color: UIColor? = .init(hexString: "333333"),
                     alignment: NSTextAlignment = .left,
                     lines: Int = 1) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
}
