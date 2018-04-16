
import Foundation

protocol UserProfileInteractor {
    func getUser(_id: String, token: String ,onSuccess: @escaping (User) -> Void, onError: errorClosure)
}



