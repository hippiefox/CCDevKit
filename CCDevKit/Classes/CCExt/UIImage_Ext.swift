//
//  UIImage_Ext.swift
//  clz
//
//  Created by cc on 2021/8/4.
//

import UIKit
public extension UIImage{
    /// create an image with a specified color
    static func cc_image(of color: UIColor)-> UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
