//
//  CCColor.swift
//  clz
//
//  Created by cc on 2021/8/5.
//

import UIKit

public  func CC_Color(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat)-> UIColor{
    UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
}

public func CC_Color(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ alpha: CGFloat)-> UIColor{
    UIColor(red: r/255, green: g/255, blue: b/255, alpha: alpha)
}

public func CC_Color(hex value: String)-> UIColor{
    var hexStr = value
    hexStr = hexStr.replacingOccurrences(of: "#", with: "")
    hexStr = hexStr.replacingOccurrences(of: "0x", with: "")
    if hexStr.count != 6 && hexStr.count != 8 {
        return .clear
    }
    
    let scanner = Scanner(string: hexStr)
    var hex64: UInt64 = 0
    let isValid = scanner.scanHexInt64(&hex64)
    if isValid == false{
        return .clear
    }
    
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 1
    
    if hexStr.count == 6 {
        r = CGFloat((hex64&0xFF0000)>>16) / 255
        g = CGFloat((hex64&0xFF00)>>8) / 255
        b = CGFloat((hex64&0xFF)>>0) / 255
    }
    
    if hexStr.count == 8 {
        r = CGFloat((hex64&0xFF000000)>>24) / 255
        g = CGFloat((hex64&0xFF0000)>>16) / 255
        b = CGFloat((hex64&0xFF00)>>8) / 255
        a = CGFloat((hex64&0xFF)>>0) / 255
    }
    
    return UIColor(red: r, green: g, blue: b, alpha: a)
}
