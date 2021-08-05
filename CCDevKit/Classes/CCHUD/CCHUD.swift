//
//  CCHUD.swift
//  CCDevKit
//
//  Created by cc on 2021/8/5.
//

import Foundation
import MBProgressHUD

open class CCHUD: MBProgressHUD {
    public static var bgColor = UIColor.black.withAlphaComponent(0.6)
    public static var hudColor = UIColor.white
    public static var labelFont = UIFont.systemFont(ofSize: 15)
    public static var labelColor = UIColor.white
    /// 显示HUD
    @discardableResult
    public static func show(onView superView: UIView? = nil,
                            text: String? = nil) -> CCHUD
    {
        let hud = CCHUD.showHUD(to: superView)
        hud.label.text = text
        return hud
    }
    
    /// 显示文字
    @discardableResult
    public static func showText(_ text: String,
                                offset: CGPoint = .zero,
                                onView superView: UIView? = nil,
                                delay: Double = 2.0) -> CCHUD
    {
        let hud = CCHUD.showHUD(to: superView)
        hud.mode = .text
        hud.label.text = text
        hud.offset = offset
        hud.hide(animated: true, afterDelay: delay)
        return hud
    }
    
    /// 隐藏HUD
    public static func hide(onView superView: UIView? = nil) {
        var view = superView
        if view == nil { view = UIApplication.shared.keyWindow }
        CCHUD.hide(for: view!, animated: true)
    }
    
    /// 进度条HUD
    @discardableResult
    public static func showProgress(onView superView: UIView? = nil,
                                    text: String? = nil) -> CCHUD
    {
        let hud = CCHUD.showHUD(to: superView)
        hud.mode = .annularDeterminate
        hud.label.text = text
        return hud
    }
    
    /// 自定义view
    @discardableResult
    public static func showCustomView(_ customView: UIView,
                                      onView superView: UIView? = nil) -> CCHUD
    {
        let hud = showHUD(to: superView)
        hud.mode = .customView
        hud.customView = customView
        hud.bezelView.color = .clear
        return hud
    }
    
    @discardableResult
    private static func showHUD(to superView: UIView?) -> CCHUD {
        var view = superView
        if view == nil { view = UIApplication.shared.delegate?.window as? UIView }
        let hud = CCHUD.showAdded(to: view!, animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = .solidColor
        hud.bezelView.color = CCHUD.bgColor
        hud.contentColor = CCHUD.hudColor
        hud.label.textColor = CCHUD.labelColor
        hud.label.font = CCHUD.labelFont
        hud.label.numberOfLines = 0
        return hud
    }
}
