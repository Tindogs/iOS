
import Foundation

class UpdateUserInteractorImpl: UpdateUserInteractor{
    
    let updateUserVC: UpdateUserViewController
    
    init (updateUserVC: UpdateUserViewController){
        self.updateUserVC = updateUserVC
    }
    
    func execute(user: User, token: String, onSuccess: @escaping(User) -> Void, onError: errorClosure) {
        
        let request: URLRequest = updateUserRequest(user: user, token: token)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    OperationQueue.main.addOperation{
                        if error == nil {
                            let user: User? = updateUserOrDogParseData(data: data!)
                            onSuccess(user!)
                        } else {
                            if let onError = onError{
                                onError(error!)
                            }
                        }
                    }
                }
                else {
                    self.updateUserVC.hideActivityIndicator(activityIndicator: self.updateUserVC.ActivityInd)
                    OperationQueue.main.addOperation {
                        self.updateUserVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), no hemos podido actualizar los datos.")
                    }
                    return
                }
            }
        }
        task.resume()
    }
}
