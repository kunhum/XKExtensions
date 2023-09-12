//
//  XKUIView+Gradient.swift
//  XKGradientSwift
//
//  Created by kenneth on 2022/3/10.
//

import Foundation
import UIKit

public class XKGradientLayer: CAGradientLayer {}

fileprivate extension UIView {
    func fetchCornerRadiusLayer() -> CALayer? {
        return layer.sublayers?.first(where: { sublayer in
            return sublayer.isKind(of: XKGradientLayer.self)
        })
    }
}

public extension UIView {

    func addGradient(startPoint: CGPoint, endPoint: CGPoint, colors: [UIColor]) {
        if let sublayer = fetchCornerRadiusLayer() {
            sublayer.removeFromSuperlayer()
        }
        let gradientLayer = XKGradientLayer()
        gradientLayer.frame      = bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint   = endPoint
        gradientLayer.colors     = colors.map({ color in
            return color.cgColor
        })
        layer.addSublayer(gradientLayer)
    }
}

public extension UIView {
    
    private struct AssociatedKey {
        static var panEdges = "UIPanGestureRecognizer.panEdges"
    }

    @objc var panEdges: UIEdgeInsets {
        set {
            objc_setAssociatedObject(self, &AssociatedKey.panEdges, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.panEdges) as? UIEdgeInsets ?? .zero
        }
    }

    // MARK: pan
    @objc func xk_panGestureMethod(pan: UIPanGestureRecognizer) {
        
        let point = pan.translation(in: self)
        var center = self.center
        center.x += point.x
        center.y += point.y
        self.center = center
        
        var needUpdateFrame = false
        var frame = self.frame
        if frame.minX < panEdges.left {
            needUpdateFrame = true
            frame.origin.x = panEdges.left
        }
        if frame.minY < panEdges.top {
            needUpdateFrame = true
            frame.origin.y = panEdges.top
        }
        let maxX = XKCommonHelper.screenWidth-panEdges.right
        if frame.maxX > maxX {
            needUpdateFrame = true
            frame.origin.x -= (frame.maxX - maxX)
        }
        let maxY = XKCommonHelper.screenHeight-panEdges.bottom
        if frame.maxY > maxY {
            needUpdateFrame = true
            frame.origin.y -= (frame.maxY - maxY)
        }
        if needUpdateFrame {
            self.frame = frame
        }
        pan.setTranslation(.zero, in: self)
    }
}
