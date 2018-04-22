
import Foundation

protocol LoginUserInteractor {
    func execute(email: String, password: String ,onSuccess: @escaping (User,_ token: String) -> Void, onError: errorClosure)
    
}
