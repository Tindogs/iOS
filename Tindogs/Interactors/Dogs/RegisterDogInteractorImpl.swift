
import Foundation

class RegisterDogInteractorImpl: RegisterDogInteractor{
    func execute(userid: String, token: String, dog: Dog, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        
        let request: URLRequest = RegisterDogRequest(userid: userid, token: token, dog: dog)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
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
        task.resume()
    }
}
