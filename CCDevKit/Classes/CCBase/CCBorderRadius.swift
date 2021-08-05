//
//  CCBorderRadius.swift
//  clz
//
//  Created by cc on 2021/8/5.
//

import UIKit

public func CC_ViewBorder(_ view: UIView, _ borderWidth: CGFloat, _ borderColor: UIColor) {
    view.layer.borderWidth = borderWidth
    view.layer.borderColor = borderColor.cgColor
}

public func CC_ViewRadius(_ view: UIView, _ radius: CGFloat) {
    view.layer.cornerRadius = radius
    view.layer.masksToBounds = true
}

public func CC_ViewBorderRadius(_ view: UIView, _ borderWidth: CGFloat, _ borderColor: UIColor, _ radius: CGFloat) {
    CC_ViewRadius(view, radius)
    CC_ViewBorder(view, borderWidth, borderColor)
}
