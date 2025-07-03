//
//  XKEnum.swift
//  TcbHallModule
//
//  Created by Kenneth Tse on 2025/5/1.
//

import Foundation

/// 三态枚举
public enum XKTreblingArrow {
    case normal
    case up
    case down
    
    public var next: XKTreblingArrow {
        switch self {
        case .normal:
                .down
        case .up:
                .normal
        case .down:
                .up
        }
    }
}

public enum XKNormalArrow {
    case up
    case down
    
    public var next: XKNormalArrow {
        switch self {
        case .up:
                .down
        case .down:
                .up
        }
    }
}
