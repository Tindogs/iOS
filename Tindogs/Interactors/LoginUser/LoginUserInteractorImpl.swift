
import UIKit

class LoginUserInteractorImpl: LoginUserInteractor {
    
    let loginVC: LogInViewController
    
    init(loginVC: LogInViewController){
        self.loginVC = loginVC
    }
    
    func execute(email: String, password: String, onSuccess: @escaping (User,_ token: String) -> Void, onError: errorClosure) {
        
        let request: URLRequest = LoginUserRequest(email:email, password: password)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
        
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    OperationQueue.main.addOperation{
                        if error == nil {
                            let (user: User, token: String) = loginUserParseData(data: data!)
                            onSuccess(User, String)
                        } else {
                            if let onError = onError{
                                onError(error!)
                            }
                        }
                    }
                }
                else {
                    self.loginVC.hideActivityIndicator(activityIndicator: self.loginVC.ActivityInd)
                    OperationQueue.main.addOperation {
                        self.loginVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), ese usuario o password son inválidos")
                    }
                    return
                }
            }
    
        }
        task.resume()
    }
}
