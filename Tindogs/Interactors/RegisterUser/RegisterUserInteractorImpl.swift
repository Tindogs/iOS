import Foundation

class RegisterUserInteractorImpl : RegisterUserInteractor {
       
    func execute(user: User, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        
//        let request: URLRequest = RegisterUserRequest(firstName: user.firstName, lastName: user.lastName, email: user.email, userName: user.userName, password: user.password)
        let request: URLRequest = RegisterUserRequest(user: user)
        
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

