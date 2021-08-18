//
//  CCRequestCacheKey.swift
//  CleanerQ
//
//  Created by cc on 2021/6/11.
//

import Foundation
import Cache

class CCRequestCacheKey: NSObject {
    /// 将参数字典转换成字符串后md5
    static func with(url: String, params: [String: Any]?) -> String {
        if let filterParams = params {
            let str = "\(url)" + "\(sort(filterParams))"
            return MD5(str)
        } else {
            return MD5(url)
        }
    }

    /// 参数排序生成字符串
    static func sort(_ parameters: [String: Any]?) -> String {
        var sortParams = ""
        if let params = parameters {
            let sortArr = params.keys.sorted { $0 < $1 }
            sortArr.forEach { str in
                if let value = params[str] {
                    sortParams = sortParams.appending("\(str)=\(value)")
                } else {
                    sortParams = sortParams.appending("\(str)=")
                }
            }
        }
        return sortParams
    }
}
