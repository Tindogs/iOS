
import Foundation

class UpdateUserInteractorImpl: UpdateUserInteractor{
    func execute(user: User, token: String, onSuccess: @escaping(User) -> Void, onError: errorClosure) {
        
        let request: URLRequest = updateUserRequest(user: user, token: token)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
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
        task.resume()
    }
    
    
}
