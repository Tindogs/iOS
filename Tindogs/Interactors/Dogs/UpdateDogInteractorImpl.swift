
import Foundation

class UpdateDogInteractorImpl: UpdateDogInteractor{
    
    let updateDogVC: DogQueryPreferencesViewController
    
    init(updateDogVC: DogQueryPreferencesViewController){
        self.updateDogVC = updateDogVC
    }
    
    func execute(userid: String, token: String, dog: Dog, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        
        let request: URLRequest = UpdateDogRequest(userid: userid, token: token, dog: dog)
        
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
                    self.updateDogVC.hideActivityIndicator(activityIndicator: self.updateDogVC.activityInd)
                    OperationQueue.main.addOperation {
                        self.updateDogVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), prueba de nuevo más tarde")
                    }
                    return
                }
            }
        }
        task.resume()
    }
}

