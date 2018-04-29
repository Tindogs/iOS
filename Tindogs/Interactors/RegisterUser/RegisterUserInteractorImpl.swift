import Foundation

class RegisterUserInteractorImpl : RegisterUserInteractor {
    
    let registerVC: RegisterViewController
    
    init(registerVC: RegisterViewController){
        self.registerVC = registerVC
    }
    
    func execute(user: User, onSuccess: @escaping (User, _ token: String) -> Void, onError: errorClosure) {
        
        let request: URLRequest = RegisterUserRequest(user: user)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    OperationQueue.main.addOperation{
                        if error == nil {
                            let (user: User, token: String) = registerUserParseData(data: data!)
                            onSuccess(User, String)
                        } else {
                            if let onError = onError{
                                onError(error!)
                            }
                        }
                    }
                }
                else {
                    self.registerVC.hideActivityIndicator(activityIndicator: self.registerVC.ActivityInd)
                    OperationQueue.main.addOperation {
                        self.registerVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), intenta de nuevo más tarde")
                    }
                    return
                }
            }
            
        }
        
        task.resume()
    }
}

