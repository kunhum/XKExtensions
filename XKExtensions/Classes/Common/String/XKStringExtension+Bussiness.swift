//
//  XKStringExtension+Bussiness.swift
//  XKCategorySwift
//
//  Created by kenneth on 2022/3/3.
//  业务向

import Foundation

public extension String {

    /// 格式化昵称
    public var nickName: String {

        let tmpNic = self as NSString

        guard tmpNic.length > 1 else {
            return self
        }
        guard tmpNic.length > 2 else {
            return tmpNic.replacingCharacters(in: NSRange(location: tmpNic.length - 1, length: 1), with: "*") as String
        }

        let prefix = tmpNic.substring(to: 1)
        let suffix = tmpNic.substring(with: NSRange(location: tmpNic.length - 1, length: 1))

        return prefix + "*" + suffix
    }
    
    public var formattedMobile: String {
        guard count > 7 else { return self }
        let middleText = xk_sub(from: 3, to: count-5)
        let securityText = String(repeating: "*", count: middleText.count)
        let startIndex = index(startIndex, offsetBy: 3)
        let endIndex = index(endIndex, offsetBy: -5)
        return replacingCharacters(in: (startIndex...endIndex), with: securityText)
    }
    
    public var securityAccount: String {
        guard count > 8 else { return self }
        let start = index(startIndex, offsetBy: 4)
        let end = index(endIndex, offsetBy: -5)
        let middleText = xk_sub(from: 4, to: count-5)
        return replacingCharacters(in: (start...end), with: String(repeating: "*", count: middleText.count))
    }
}
