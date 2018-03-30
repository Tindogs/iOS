import Foundation

class RegisterUserInteractorImpl : RegisterUserInteractor {
    
    func execute(firstName: String, lastName: String, email: String, userName: String, password: String, onSuccess: @escaping (User) -> Void) {
        execute(firstName: firstName, lastName: lastName, email: email, userName: userName, password: password, onSuccess: onSuccess, onError: nil)
    }
    
    func execute(firstName: String, lastName: String, email: String, userName: String, password: String, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        
        let request: URLRequest = RegisterUserRequest(firstName: firstName, lastName: lastName, email: email, userName: userName, password: password)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
        
            OperationQueue.main.addOperation{
                if error == nil {
                    let user: User? = registerUserParseData(data: data!)
                    onSuccess(user!)
                } else {
                    if let onError = onError{
                        onError(error!)
                    }
                }
            }
        }
        task.resume()
    }
}

