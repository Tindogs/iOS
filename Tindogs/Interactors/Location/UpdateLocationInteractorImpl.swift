
import Foundation

class UpdateLocationInteractorImpl: UpdateLocationInteractor{
    func execute(userid: String, token: String, coordinates: [Double], onError: errorClosure) {
        
        let request: URLRequest = updateLocationRequest(userId: userid, token: token, coordinates: coordinates)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            OperationQueue.main.addOperation{
                if error != nil {
                    if let onError = onError{
                        onError(error!)
                    }
                }
            }
        }
        task.resume()
    }
}


