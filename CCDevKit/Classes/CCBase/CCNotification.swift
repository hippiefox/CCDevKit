//
//  CCNotification.swift
//  CCDevKit
//
//  Created by cc on 2021/8/5.
//

import Foundation

public protocol CCNoti {
    var name: String{   get}
}

public func CCNotification(post noti: CCNoti, userInfo: [AnyHashable: Any]? = nil) {
    NotificationCenter.default.post(name: .init(rawValue: noti.name), object: nil, userInfo: userInfo)
}

public func CCNotification(observer: Any, selector: Selector, noti: CCNoti) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: .init(rawValue: noti.name), object: nil)
}

public func CCNotification(remove observer: Any) {
    NotificationCenter.default.removeObserver(observer)
}
