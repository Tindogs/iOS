
import Foundation

protocol UpdateDogInteractor {
    func execute(userid: String, token: String, dog: Dog, onSuccess: @escaping(User) -> Void, onError: errorClosure)
}
