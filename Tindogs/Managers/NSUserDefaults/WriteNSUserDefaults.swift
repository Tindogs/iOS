
import Foundation

func writeNSUserDefaults(_id: String, token: String) -> Bool {
    
    let defaults = UserDefaults.standard
    
    defaults.set(_id, forKey: CONSTANTS.userDefaults_id)
    defaults.set(token, forKey: CONSTANTS.userDefaultsToken)
    
    return defaults.synchronize()
}
