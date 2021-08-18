//
//  CCDevice.swift
//  Alamofire
//
//  Created by cc on 2021/8/18.
//

import Foundation
import UIKit
import AppTrackingTransparency
import AdSupport
import KeychainAccess


public struct FXDevice{
    public static let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    
    public static let bundleId = Bundle.main.bundleIdentifier!
                   
    public static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

    // 系统语言
    public static let localLanguage = Locale.preferredLanguages[0]
    
    public static var language: String {
        Locale.preferredLanguages[0].components(separatedBy: "-").first!
    }
    
    // 国家编码 IN  US CN JP
    public static let countryCode = (NSLocale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String ?? ""
    
    // 国家名称（中文）
    public static var countryName: String {
        let CNLocale = NSLocale(localeIdentifier: "zh_Hans_CN")
        let displayNameString = CNLocale.displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
        return displayNameString ?? ""
    }
    
    /// 设备名称 "My iPhone"
    public static let deviceName = UIDevice.current.name
    /// 系统名称 "iPhone OS"
    public static let systemName = UIDevice.current.systemName
    /// 系统版本 "9.2"
    public static let systemVersion = UIDevice.current.systemVersion
    /// 设备的型号 "iPhone, iPod"
    public static let deviceModel = UIDevice.current.model

    //MARK: - IDFA
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
    public static func requestATT(){
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                print("【FXDevice】ATT auth status:",status.rawValue)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: - Unique ID
    public static var uniqueID: String {
        let account = FXDevice.bundleId
        let bundleID = FXDevice.bundleId
        
        let keychain = Keychain(service: bundleID)
        if let id = try? keychain.get(account) {
            return id ?? ""
        }
        
        let uuid = CFUUIDCreate(kCFAllocatorDefault)
        let uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuid) as String? ?? ""
        
        do {
            try keychain.set(uuidString, key: account)
            return uuidString
        } catch  {
            return ""
        }
    }

}
