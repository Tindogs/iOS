
import Foundation

class GetUserInteractorImpl: GetUserInteractor {
    func execute(userId: String, token: String, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        
        let request: URLRequest = getUserRequest(userId: userId,token: token)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
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
        task.resume()
    }
}
