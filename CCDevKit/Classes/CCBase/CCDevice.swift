//
//  CCDevice.swift
//  clz
//
//  Created by cc on 2021/8/5.
//

import Foundation
import AdSupport
import KeychainAccess
import UIKit
import AppTrackingTransparency



public struct CCDevice {
    // app名称
    public static let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    // bundleId
    public static let bundleId = Bundle.main.bundleIdentifier!
    // 版本号
    public static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    // idfa
    public static var idfa: String = {
        if #available(iOS 14, *){
            if case .authorized = ATTrackingManager.trackingAuthorizationStatus{
                return ASIdentifierManager.shared().advertisingIdentifier.uuidString
            }else{
                return ""
            }
        }else{
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                return ASIdentifierManager.shared().advertisingIdentifier.uuidString
            } else {
                return ""
            }
        }
    }()

    // 系统语言
    public static let localLanguage = Locale.preferredLanguages[0]
    public static var language: String {
        return Locale.preferredLanguages[0].components(separatedBy: "-").first!
    }

    // 国家编码 IN  US CN JP
    public static let countryCode = (NSLocale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String ?? ""
    // 国家名称（中文）
    public static var countryName: String {
        let CNLocale = NSLocale(localeIdentifier: "zh_Hans_CN")
        let displayNameString = CNLocale.displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
        return displayNameString ?? ""
    }

    // 唯一标识
    public static var uniqueID: String {
        let account = CCDevice.bundleId
        let bundleID = CCDevice.bundleId
        let keychain = Keychain(service: bundleID)
        if let id = try? keychain.get(account) {
            return id
        }
        let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
        let uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuidRef) as String? ?? ""
        do {
            try keychain.set(uuidString, key: account)
            return uuidString
        } catch {
            return ""
        }
    }

    /// 设备名称 "My iPhone"
    public static let deviceName = UIDevice.current.name
    /// 系统名称 "iPhone OS"
    public static let systemName = UIDevice.current.systemName
    /// 系统版本 "9.2"
    public static let systemVersion = UIDevice.current.systemVersion
    /// 设备的型号 "iPhone, iPod"
    public static let deviceModel = UIDevice.current.model
}
