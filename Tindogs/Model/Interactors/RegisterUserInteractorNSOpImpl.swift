import Foundation

class RegisterUserInteractorNSOpImpl : RegisterUserInteractor {

//    var user: User?
    
    func execute(firstName: String, lastName: String, email: String, userName: String, password: String, onSuccess: @escaping (User) -> Void) {
        execute(firstName: firstName, lastName: lastName, email: email, userName: userName, password: password, onSuccess: onSuccess, onError: nil)
    }
    
    func execute(firstName: String, lastName: String, email: String, userName: String, password: String, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        
        let url = URL(string: baseUrl + EndPoints.registerUser.rawValue)
        var request = URLRequest(url:url!)

        
        request.httpMethod = Method.POST.rawValue
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // fill dictionary
        let dictionary = ["first_name": firstName, "last_name": lastName, "email": email,"username": userName,"password": password] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        }  catch let error {
            if let onError = onError{
                onError(error)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            OperationQueue.main.addOperation {
            
                if error != nil {
                    if let onError = onError{
                        onError(error!)
                    }
                }
            
                let user: User? = registerUserParseData(data: data!)
                
                onSuccess(user!)
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
//
//                    if let parseJson = json {
//                        if ((json?.value(forKey: "success") as! Bool) == true) {
//
//                            // TODO : EL TOKEN HABRA QUE GUARDARLO EN EL KEYCHAIN
//                            let token = json?.value(forKey: "token") as! String
//                            let result = parseJson.object(forKey: "result") as! NSDictionary
//
//                            // TODO : MAPEO A OBJETOS, CUANTO TENGAMOS COREDATA
//                            let first_name  = result.value(forKey: "first_name") as! String
//                            let last_name   = result.value(forKey: "last_name") as! String
//                            let email       = result.value(forKey: "email") as! String
//                            let username    = result.value(forKey: "username") as! String
//                            let _id         = result.value(forKey: "_id") as! String
//
//                            self.user = User(_id: _id, firstName: first_name, lastName: last_name, email: email, userName: username, password: password)
//
//                            onSuccess(self.user!)
//                        }
//                    }
//                }
//                catch {
//                    if let onError = onError{
//                        onError(error)
//                    }
//                }
            } // Cierre operationQueue
        } // cierre task
        task.resume()
    } // Cierre func Execute
}

