//
//  CCSize.swift
//  CCDevKit
//
//  Created by cc on 2021/8/5.
//

import Foundation
import  UIKit

public let CC_SCREEN_WIDTH = UIScreen.main.bounds.width
public let CC_SCREEN_HEIGHT = UIScreen.main.bounds.height
public let CC_SAFEAREA_INSETS = UIApplication.shared.keyWindow!.safeAreaInsets
public let CC_NAVIGATION_BAR_HEIGHT: CGFloat = CC_SAFEAREA_INSETS.top > 0 ? CC_SAFEAREA_INSETS.top + 44 : 64

public func CC_BaseLine(_ a: CGFloat, baseValue: CGFloat = 375) -> CGFloat {
    a * CC_SCREEN_WIDTH / baseValue
}
