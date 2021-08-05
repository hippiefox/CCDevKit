
import Foundation
import Moya

public enum CCRequestType {
    case onlyRequest
    case requestAndCache
    case onlyReadCache
}

public protocol CCTargetType: TargetType {
    // 参数
    var params: [String: Any] { get }
    // 超时时间
    var timeoutInterval: TimeInterval { get }
    // 需要uid
    var needUID: Bool { get }
    // 需要缓存
    var requestType: CCRequestType { get }
    // 需要加密请求, 需要在Task中做判断
    var needEncryption: Bool { get }
    // 需要打印log
    var needJsonLog: Bool { get }
}

public extension CCTargetType {
    var timeoutInterval: TimeInterval { return 60 }
    var needEncryption: Bool { return true }
    var needJsonLog: Bool { return true }
    
    var sampleData: Data { return Data() }
    var headers: [String : String]? { return nil }
}
