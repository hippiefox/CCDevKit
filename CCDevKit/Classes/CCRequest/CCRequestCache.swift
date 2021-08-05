
import Foundation

import Cache

struct CCRequestCacheModel: Codable {
    var data: Data?
}

class CCRequestCache: NSObject {
    static let `default` = CCRequestCache()

    private var storage: DiskStorage<String, CCRequestCacheModel>?
    override init() {
        super.init()
        storage = try? DiskStorage<String, CCRequestCacheModel>(config: .init(name: "CCRequestCache"), transformer: TransformerFactory.forCodable(ofType: CCRequestCacheModel.self))
    }

    func removeAll() {
        try? storage?.removeAll()
    }

    func removeObject(forKey cacheKey: String) {
        try? storage?.removeObject(forKey: cacheKey)
    }

    func object(forKey cacheKey: String) -> CCRequestCacheModel? {
        return try? storage?.object(forKey: cacheKey)
    }

    func setCache(_ obj: CCRequestCacheModel, forKey cacheKey: String, expiry: Expiry? = nil) {
        DispatchQueue.global().async {
            try? self.storage?.setObject(obj, forKey: cacheKey, expiry: expiry)
        }
    }
}
