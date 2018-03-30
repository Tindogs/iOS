import Foundation

class RegisterUserInteractorNSOpImpl : RegisterUserInteractor {
    
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
            }
        }
        task.resume()
    }
}

