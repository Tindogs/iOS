
import Foundation

protocol ReadKeyUserInfoProtocol {
    func get() -> ReadKeyUserInfo
}

final class ReadKeyUserInfo: ReadKeyUserInfoProtocol {
    let token: String
    let userId: String
    
    init(token: String, userId: String) {
        self.token = token
        self.userId = userId
    }
    
    func get() -> ReadKeyUserInfo {
        let defaults = UserDefaults.standard
        let _id = defaults.string(forKey: "_id")
        let token = defaults.string(forKey: "token")
        var keyUserInfo: ReadKeyUserInfo?
        
        if let _id = _id, let token = token {
            keyUserInfo = ReadKeyUserInfo(token: token, userId: _id)
        }
        
        return keyUserInfo!
    }
}

