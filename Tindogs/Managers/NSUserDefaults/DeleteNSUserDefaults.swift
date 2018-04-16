
import Foundation

func deleteNSUserDefaults() {
    
    let defaults = UserDefaults.standard
    
    //        print("-------------------BEFORE-------------------")
    //        print (defaults.string(forKey: CONSTANTS.userDefaults_id))
    //        print (defaults.string(forKey: CONSTANTS.userDefaultsToken))
    
    defaults.removeObject(forKey:CONSTANTS.userDefaults_id)
    defaults.removeObject(forKey:CONSTANTS.userDefaultsToken)
    
    //        print("-------------------AFTER-------------------")
    //        print (defaults.string(forKey: CONSTANTS.userDefaults_id))
    //        print (defaults.string(forKey: CONSTANTS.userDefaultsToken))
}
