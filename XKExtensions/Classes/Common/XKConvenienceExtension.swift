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

public extension UIButton {
    convenience init(type: ButtonType = .custom,
                     title: String = "",
                     titleColor: UIColor? = nil,
                     selectedTitle: String? = nil,
                     selectedTitleColor: UIColor? = nil,
                     font: UIFont? = nil,
                     lines: Int? = nil,
                     image: UIImage? = nil,
                     selectedImage: UIImage? = nil,
                     backgroundColor: UIColor? = nil,
                     cornerRadius: Double? = nil,
                     borderWidth: Double? = nil,
                     borderColor: UIColor? = nil) {
        self.init(type: type)
        setTitle(title, for: .normal)
        if let title = selectedTitle {
            setTitle(title, for: .selected)
        }
        setImage(image, for: .normal)
        if let image = selectedImage {
            setImage(image, for: .selected)
        }
        if let color = titleColor {
            setTitleColor(color, for: .normal)
        }
        if let color = selectedTitleColor {
            setTitleColor(color, for: .selected)
        }
        if let font = font {
            titleLabel?.font = font
        }
        if let lines = lines {
            titleLabel?.numberOfLines = lines
        }
        if let radius = cornerRadius {
            layer.cornerRadius = radius
        }
        if let color = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let width = borderWidth {
            layer.borderWidth = width
        }
        if let color = borderColor {
            layer.borderColor = color.cgColor
        }
    }
}

public extension UITextField {
    convenience init(text: String? = nil,
                     textColor: UIColor = .firstText,
                     font: UIFont = .xk_pingFangSC(size: 16),
                     placeholder: NSAttributedString? = nil,
                     clearButtonMode: UITextField.ViewMode = .never) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.attributedPlaceholder = placeholder
        self.clearButtonMode = clearButtonMode
    }
}

public extension UIView {
    convenience init(backgroundColor: UIColor? = nil,
                     cornerRadius: Double? = nil,
                     borderWidth: Double? = nil,
                     borderColor: UIColor? = nil,
                     tag: Int? = nil) {
        self.init()
        if let bg = backgroundColor {
            self.backgroundColor = bg
        }
        if let cornerRadius = cornerRadius {
            self.cornerRadius = cornerRadius
        }
        if let width = borderWidth {
            self.borderWidth = width
        }
        if let color = borderColor {
            self.borderColor = color
        }
        if let tag = tag {
            self.tag = tag
        }
    }
}

public extension UITableView {
    convenience init(style: Style = .plain,
                     delegate: (any UITableViewDelegate),
                     dataSource: (any UITableViewDataSource),
                     rowHeight: Double = UITableView.automaticDimension,
                     backgroundColor: UIColor = .white,
                     separatorColor: UIColor = .xkSeparator,
                     separatorInset: UIEdgeInsets? = nil,
                     separatorStyle: UITableViewCell.SeparatorStyle? = nil) {
        
        self.init(frame: .zero, style: style)
        self.delegate = delegate
        self.dataSource = dataSource
        self.rowHeight = rowHeight
        self.separatorColor = separatorColor
        self.backgroundColor = backgroundColor
        if let inset = separatorInset {
            self.separatorInset = inset
        }
        if let separatorStyle = separatorStyle {
            self.separatorStyle = separatorStyle
        }
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = Double.leastNormalMagnitude
        }
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
    }
}
