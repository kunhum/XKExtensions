//
//  XKUIView+Gradient.swift
//  XKGradientSwift
//
//  Created by kenneth on 2022/3/10.
//

import Foundation
import UIKit
import Photos
import MJRefresh

public class XKGradientLayer: CAGradientLayer {}

fileprivate extension UIView {
    func fetchCornerRadiusLayer() -> CALayer? {
        return layer.sublayers?.first(where: { sublayer in
            return sublayer.isKind(of: XKGradientLayer.self)
        })
    }
}

private struct UIViewAssociatedKeys {
    
}

public extension UIView {
    
    class func makeRoundedView(background: UIColor = .white, cornerRadius: Double = 10) -> UIView {
        let view = UIView(backgroundColor: background, cornerRadius: cornerRadius)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    /// 渐变
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
    /// 设置优先级
    func set(priority: UILayoutPriority, axis: NSLayoutConstraint.Axis = .horizontal) {
        setContentCompressionResistancePriority(priority, for: axis)
        setContentHuggingPriority(priority, for: axis)
    }
    
    /// save view as image
    func saveImage(callback: ((_ result: Bool) -> Void)?) {
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            callback?(false)
            return
        }
        layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            callback?(false)
            return
        }
        
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                callback?(false)
                return
            }
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            } completionHandler: { result, _ in
                callback?(result)
            }
        }
    }
}
 
public extension UITextField {
    func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        guard isSecureTextEntry else { return true }
        // UITextField 切换 isSecureTextEntry = true 后，输入新的内容时，之前输入的内容被清空
        let textFieldContent = (text as? NSString)?.replacingCharacters(in: range, with: string)
        text = textFieldContent
        return false
    }
}
 
public extension UIButton {
    
    enum ImagePosition {
        case left
        case right
        case top
        case bottom
    }
    
    /// set the position of image
    /// - Parameters:
    ///   - position: position
    ///   - spacing: spacing
    ///   - offset: in usual, top/bottom: >0 go down, <0 go up、 left/right: >0 go right, <0 go left
    func set(position: ImagePosition, spacing: Double, offset: Double? = 0) {
        
        setTitle(currentTitle, for: .normal)
        setImage(currentImage, for: .normal)
        
        let imageWidth = currentImage?.size.width ?? 1
        let imageHeight = currentImage?.size.height ?? 1
        let labelSize = titleLabel?.sizeThatFits(.zero)
        let labelWidth = labelSize?.width ?? 1
        let labelHeight = labelSize?.height ?? 1
        
        // image中心移动的x距离
        var imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth
        if contentHorizontalAlignment == .center {
            imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth*0.5
        }
        // image中心移动的y距离
        var imageOffsetY = labelHeight / 2 + spacing
        // label中心移动的x距离
        var labelOffsetX = (imageWidth + labelWidth/2) - (imageWidth + labelWidth) / 2
        //label中心移动的y距离
        var labelOffsetY = imageHeight / 2 + spacing / 2
        
        let imageInsets = imageEdgeInsets
        let titleInsets = titleEdgeInsets
        let contentInsets = contentEdgeInsets
        
        switch position {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: imageInsets.top,
                                           left: -spacing/2,
                                           bottom: imageInsets.bottom,
                                           right: spacing/2)
            titleEdgeInsets = UIEdgeInsets(top: titleInsets.top,
                                           left: spacing/2,
                                           bottom: titleInsets.bottom,
                                           right: -spacing/2)
            contentEdgeInsets = UIEdgeInsets(top: contentInsets.top,
                                             left: spacing/2,
                                             bottom: contentInsets.bottom,
                                             right: spacing/2)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: imageInsets.top,
                                           left: labelWidth + spacing/2,
                                           bottom: imageInsets.bottom,
                                           right: -(labelWidth + spacing/2))
            titleEdgeInsets = UIEdgeInsets(top: titleInsets.top,
                                           left: -(imageWidth + spacing/2),
                                           bottom: titleInsets.bottom,
                                           right: imageWidth + spacing/2)
            contentEdgeInsets = UIEdgeInsets(top: contentInsets.top,
                                             left: spacing / 2,
                                             bottom: contentInsets.bottom,
                                             right: spacing / 2)
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY,
                                           left: imageOffsetX,
                                           bottom: imageOffsetY,
                                           right: -imageOffsetX)
            titleEdgeInsets = UIEdgeInsets(top: labelOffsetY,
                                           left: -labelOffsetX,
                                           bottom: -labelOffsetY,
                                           right: labelOffsetX)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: imageOffsetY,
                                           left: imageOffsetX,
                                           bottom: -imageOffsetY,
                                           right: -imageOffsetX)
            titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY,
                                           left: -labelOffsetX,
                                           bottom: labelOffsetY,
                                           right: labelOffsetX)
            
        }
         
        if let offset, (position == .top || position == .bottom) {
            imageEdgeInsets.top += offset
            imageEdgeInsets.bottom -= offset
            titleEdgeInsets.top += offset
            titleEdgeInsets.bottom -= offset
        }
        
        if let offset, (position == .left || position == .right) {
            imageEdgeInsets.left += offset
            imageEdgeInsets.right -= offset
            titleEdgeInsets.left += offset
            titleEdgeInsets.right -= offset
        }
        
    }
}

public extension UITableView {
    func setup(header: MJRefreshHeader? = nil, footer: MJRefreshFooter? = nil) {
        mj_header = header
        mj_footer = footer
    }
}
