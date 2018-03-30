import Foundation

func registerUserParseData (data: Data) -> User {
    
    var user: User?
    
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
        
        if let parseJson = json {
            if ((json?.value(forKey: "success") as! Bool) == true) {
                
                // TODO : EL TOKEN HABRA QUE GUARDARLO EN EL KEYCHAIN/NS USER DEFAULTS
                let token = json?.value(forKey: "token") as! String
                let result = parseJson.object(forKey: "result") as! NSDictionary
                
                // TODO : MAPEO A OBJETOS, CUANTO TENGAMOS COREDATA
                let _id         = result.value(forKey: "_id") as! String
                let first_name  = result.value(forKey: "first_name") as! String
                let last_name   = result.value(forKey: "last_name") as! String
                let email       = result.value(forKey: "email") as! String
                let username    = result.value(forKey: "username") as! String
                
                user = User(_id: _id, firstName: first_name, lastName: last_name, email: email, userName: username, password: "")
            }
        }
    } catch {
        print("💩 Error parsing RegisterUserJSONParser")
    }
    return user!
}
