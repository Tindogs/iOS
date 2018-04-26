import Foundation

func registerUserParseData (data: Data) -> (user:User, token: String) {
    
    var user: User?
    var token : String?
    
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
        
        if let parseJson = json {
            if ((json?.value(forKey: "success") as! Bool) == true) {
                let jsonToken = json?.value(forKey: "token") as! String
                token = jsonToken
                let result = parseJson.object(forKey: "result") as! NSDictionary
                
                let _id         = result.value(forKey: "_id") as! String
                let first_name  = result.value(forKey: "first_name") as! String
                let last_name   = result.value(forKey: "last_name") as! String
                let email       = result.value(forKey: "email") as! String
                let username    = result.value(forKey: "username") as! String
                let password    = result.value(forKey: "password") as! String
                let photo       = result.value(forKey: "photo") as! String
                
                user = User(_id: _id, firstName: first_name, lastName: last_name, email: email, userName: username, password: password, photo: photo)
            }
        }
    } catch {
        print("💩 Error parsing RegisterUserJSONParser")
    }
    return (user!, token!)
}
