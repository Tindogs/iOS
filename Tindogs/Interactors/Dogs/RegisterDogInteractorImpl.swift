
import Foundation

class RegisterDogInteractorImpl: RegisterDogInteractor{
    
    let dogVC: DogViewController
    
    init(dogVC: DogViewController){
        self.dogVC = dogVC
    }
    
    func execute(userid: String, token: String, dog: Dog, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        
        let request: URLRequest = RegisterDogRequest(userid: userid, token: token, dog: dog)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    OperationQueue.main.addOperation{
                        if error == nil {
                            let user: User? = registerDogParseData(data: data!)
                            onSuccess(user!)
                        } else {
                            if let onError = onError{
                                onError(error!)
                            }
                        }
                    }
                }
                else {
                    self.dogVC.hideActivityIndicator(activityIndicator: self.dogVC.ActivityInd)
                    OperationQueue.main.addOperation {
                        self.dogVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), prueba de nuevo más tarde.")
                    }
                    return
                }
            }
        }
        task.resume()
    }
}
