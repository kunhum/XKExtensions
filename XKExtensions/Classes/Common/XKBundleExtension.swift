//
//  XKBundleExtension.swift
//  XKExtensions
//
//  Created by kenneth on 2023/5/26.
//

import Foundation

public extension Bundle {
    
    class func subBundle(cls: Swift.AnyClass, clsName: String) -> Bundle? {
        let bundle = Bundle(for: cls)
        guard let url = bundle.url(forResource: clsName, withExtension: "bundle") else { return nil }
        return Bundle(url: url)
    }
    
}
