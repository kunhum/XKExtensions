//
//  XKStringExtension+Date.swift
//  XKExtensions
//
//  Created by kenneth on 2023/6/8.
//

import Foundation

public extension String {
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func dateString(fromFormat: String, toFormat: String) -> String? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = fromFormat
        guard let date = dateFormat.date(from: self) else { return nil }
        dateFormat.dateFormat = toFormat
        return dateFormat.string(from: date)
    }
    
    /// format
    /// - Parameters:
    ///   - format: _
    ///   - needToDoToday: if true , today will display "今天"
    /// - Returns: _
    func dateString(withFormat format: String = "yyyy-MM-dd HH:mm:ss", toFormat: String = "yyyy-MM-dd HH:mm", needToDoToday: Bool = true) -> String? {
        let date = date(withFormat: format)
        return date?.xk_formatDisplayDate(dateFormat: toFormat)
    }
}

@objc public extension NSString {
    func date(withFormat format: String) -> Date? {
        return (self as String).date(withFormat: format)
    }
}
