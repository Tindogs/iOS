
import Foundation

protocol UserProfileInteractor {
    func getUser(user: User ,onSuccess: @escaping (User) -> Void, onError: errorClosure)
}



