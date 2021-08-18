//
//  CCRequest.swift
//  CCDevKit
//
//  Created by cc on 2021/8/5.
//

import Foundation
import Moya

public struct CCRequstConfigure {
    public static var JSON_KEY_CODE = "code"
    public static var JSON_KEY_MESSAGE = "msg"
    public static var JSON_KEY_DATA = "data"
    public static var JSON_PARSE_SUCCESS_CODE = 1
    public static var JSON_PARSE_FAILED_CODE = 88888
    public static var RSA_KEY_PUBLIC = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQClm1zd5WUVN7hQn2BYyY7wMzu8\nvI6nZql4mtDLfQrHEF4/Z8Bh5vk588v6tez2WC3hqy1zQYlZhCUt2SMDmxM3tou+\nc9rh9nXrWXAsydTMAN7tuwTRlwxmbKDy84gzs9sHzlLshStutwOcKGgw2M1b1bqM\n4lgRQpnbOQBGbEZAMQIDAQAB\n-----END PUBLIC KEY-----\n"
}

/// 响应
public struct CCHttpResponse {
    public let code: Int
    public let data: Any
    public let msg: String
    public let isCache: Bool
    public init(code: Int, data: Any, msg: String, isCache: Bool) {
        self.code = code
        self.data = data
        self.msg = msg
        self.isCache = isCache
    }
}

/// 错误
public struct CCHttpError {
    public let code: Int
    public let msg: String

    public init(code: Int, msg: String) {
        self.code = code
        self.msg = msg
    }
}

public enum CCHttpResult<Value0, Value1> {
    case success(Value0)
    case failure(Value1)
}

public typealias CCRequestCompletion = (_ result: CCHttpResult<CCHttpResponse, CCHttpError>) -> Void

public class CCRequest<target: CCTargetType>: NSObject {
    /// 请求
    /// - Parameters:
    ///   - target: ——
    ///   - completion: ——
    public static func request(_ target: target,
                               completion: @escaping CCRequestCompletion)
    {
        let url = target.baseURL.absoluteString + target.path
        let cacheKey = CCRequestCacheKey.with(url: url, params: target.params)
        /// 读取缓存
        if target.requestType == .requestAndCache || target.requestType == .onlyReadCache,
           let cacheData = CCRequestCache.default.object(forKey: cacheKey)?.data,
           let json = try? JSONSerialization.jsonObject(with: cacheData, options: []) as? [String: Any],
           let code = json[CCRequstConfigure.JSON_KEY_CODE] as? Int,
           let msg = json[CCRequstConfigure.JSON_KEY_MESSAGE] as? String,
           let data = json[CCRequstConfigure.JSON_KEY_DATA],
           code == CCRequstConfigure.JSON_PARSE_SUCCESS_CODE {
            let response = CCHttpResponse(code: code, data: data, msg: msg, isCache: true)
            completion(.success(response))
        }
        // 只读缓存
        if target.requestType == .onlyReadCache {
            return
        }
        CCRequest.provider(timeout: target.timeoutInterval).request(target) { result in
            switch result {
            case let .success(response):
                switch target.task {
                case .downloadDestination,
                     .downloadParameters:
                    completion(.success(CCHttpResponse(code: CCRequstConfigure.JSON_PARSE_SUCCESS_CODE, data: "", msg: "download success", isCache: false)))
                    return
                default:
                    var json: [String: Any] = [:]
                    // 需要加密请求
                    if target.needEncryption == false {
                        guard let jsonDict = try? response.mapJSON() as? [String: Any] else {
                            let error = CCHttpError(code: CCRequstConfigure.JSON_PARSE_FAILED_CODE, msg: "error")
                            completion(.failure(error))
                            return
                        }
                        json = jsonDict
                    } else {
//                        guard let rsaString = try? response.mapString(),
//                              let jsonString = RSA.decryptString(rsaString, publicKey: CCRequstConfigure.RSA_KEY_PUBLIC),
//                              let jsonData = jsonString.data(using: .utf8),
//                              let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
//                        else {
                            let error = CCHttpError(code: CCRequstConfigure.JSON_PARSE_FAILED_CODE, msg: "error")
                            completion(.failure(error))
//                            return
//                        }
//                        json = jsonDict
                    }
                    if target.needJsonLog {
                        print(json)
                    }
                    if let code = json[CCRequstConfigure.JSON_KEY_CODE] as? Int,
                       let msg = json[CCRequstConfigure.JSON_KEY_MESSAGE] as? String,
                       let data = json[CCRequstConfigure.JSON_KEY_DATA],
                       code == CCRequstConfigure.JSON_PARSE_SUCCESS_CODE {
                        // 写入缓存
                        if target.requestType == .requestAndCache || target.requestType == .onlyReadCache,
                           let data = try? JSONSerialization.data(withJSONObject: json, options: [])
                        {
                            var model = CCRequestCacheModel()
                            model.data = data
                            CCRequestCache.default.setCache(model, forKey: cacheKey)
                        }

                        let response = CCHttpResponse(code: code, data: data, msg: msg, isCache: false)
                        completion(.success(response))

                    } else {
                        let smError = CCHttpError(code: CCRequstConfigure.JSON_PARSE_FAILED_CODE, msg: "error")
                        completion(.failure(smError))
                    }
                }

            case let .failure(error):
                let mhError = CCHttpError(code: error.errorCode, msg: error.localizedDescription)
                completion(.failure(mhError))
            }
        }
    }
}

// MARK: - 超时时间

extension CCRequest {
    private static func provider<target: CCTargetType>(timeout: TimeInterval) -> MoyaProvider<target> {
        let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<target>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = timeout
                done(.success(request))
            } catch {
                return
            }
        }
        let provider = MoyaProvider<target>(requestClosure: requestTimeoutClosure)
        return provider
    }
}
