
import Foundation

protocol RegisterDogInteractor {
    func execute(userid: String, token: String, dog: Dog, onSuccess: @escaping(User) -> Void, onError: errorClosure)
}
