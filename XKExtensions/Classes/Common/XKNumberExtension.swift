//
//  XKNumberExtension.swift
//  XKCategorySwift
//
//  Created by kenneth on 2022/3/3.
//

// swiftlint:disable identifier_name
import Foundation

let Angle = { arc in
    return Double.pi / 180.0 * arc
}

public enum DoubleRoundedUnit: Double {
    ///万亿
    case trillion = 1_000_000_000_000.0
    ///亿
    case hundredMillion = 100_000_000.0
    ///万
    case tenThousand = 10_000.0
}

public extension CGFloat {
    var angle: CGFloat {
        return CGFloat(Double(self).angle)
    }
}

public extension Double {

    var angle: Double {
        return Angle(self)
    }

    var symbol: String {
        return self > 0.0 ? "+" : ""
    }

    var unit: String {
        let value = fabs(self)
        if value >= DoubleRoundedUnit.trillion.rawValue {
            return "万亿"
        } else if value >= DoubleRoundedUnit.hundredMillion.rawValue {
            return "亿"
        } else {
            return "万"
        }
    }

    /// 格式化距离，返回*m，*km
    var distance: String {
        guard self > 1_000.0 else {
            return "\(self)" + "m"
        }
        return String(format: "%.1fkm", self / 1_000.0)
    }

    func rounded(byUnit unit: DoubleRoundedUnit, compareNumber: Int = 5) -> Int {

        let value            = self / unit.rawValue
        let roundedValue     = value.rounded(.awayFromZero)
        let valueComponenets = String(format: "%.1f", roundedValue / 10.0).components(separatedBy: ".")

        var lastValue  = valueComponenets.last?.xk_toInt() ?? 0
        var firstValue = Swift.abs(valueComponenets.first?.xk_toInt() ?? 0)

        guard lastValue != 0 else {
            return Int(roundedValue)
        }

        if lastValue > compareNumber {
            lastValue  = 0
            firstValue += 1
        } else {
            lastValue = compareNumber
        }

        let intValue = ([firstValue, lastValue] as NSArray).componentsJoined(by: "").xk_toInt() ?? 0

        return (value < 0.0) ? intValue * -1 : intValue
    }

    func digitText(_ number: Int, needFormatterPrice: Bool = false) -> String {
        var value = self
        if needFormatterPrice {
            // 万亿
            if fabs(value) >= DoubleRoundedUnit.trillion.rawValue {
                value /= DoubleRoundedUnit.trillion.rawValue
            } else if fabs(value) >= DoubleRoundedUnit.hundredMillion.rawValue {//亿
                value /= DoubleRoundedUnit.hundredMillion.rawValue
            } else {//万
                value /= DoubleRoundedUnit.tenThousand.rawValue
            }
        }
        let format = "%." + "\(number)" + "f"
        return String(format: format, value)
    }

}

public extension Int64 {
    func date() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

public extension Int32 {
    func date() -> Date {
        return Int64(self).date()
    }
}

public extension Int {
    func date() -> Date {
        return Int64(self).date()
    }
    func format(digits: Int = 0) -> String {
        return Double(self).format(digits: digits)
    }
}

public extension Double {
    
    func date() -> Date {
        return Date(timeIntervalSince1970: self)
    }
    
    func format(digits: Int = 2) -> String {
        return String(format: "%.\(digits)f", self)
    }
}
