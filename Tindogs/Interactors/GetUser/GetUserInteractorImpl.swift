
import Foundation

class GetUserInteractorImpl: GetUserInteractor {
    
    let loginVC: LogInViewController
    
    init(loginVC: LogInViewController){
        self.loginVC = loginVC
    }
    
    func execute(userId: String, token: String, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        
        let request: URLRequest = getUserRequest(userId: userId,token: token)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    OperationQueue.main.addOperation{
                        if error == nil {
                            let user: User? = getUserParseData(data: data!)
                            onSuccess(user!)
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
                        self.loginVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), no hemos podido encontrar tu usuario")
                    }
                    return
                }
            }
        }
        task.resume()
    }
}
