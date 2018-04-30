
import Foundation

class UpdateLocationInteractorImpl: UpdateLocationInteractor{
    
    let UserProfileVC: UserProfileViewController
    
    init(UserProfileVC: UserProfileViewController){
        self.UserProfileVC = UserProfileVC
    }
    
    func execute(userid: String, token: String, coordinates: [Double], onError: errorClosure) {
        
        let request: URLRequest = updateLocationRequest(userId: userid, token: token, coordinates: coordinates)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    OperationQueue.main.addOperation{
                        if error != nil {
                            if let onError = onError{
                                onError(error!)
                            }
                        }
                    }
                }
                else {
                    OperationQueue.main.addOperation {
                        self.UserProfileVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), actualizando tus coordenadas, lo intentaremos luego de nuevo.")
                    }
                    return
                }
            }
        }
        task.resume()
    }
}


