
import Foundation

protocol UpdateUserInteractor {
    func execute(user: User, token: String, onSuccess: @escaping(User) -> Void, onError: errorClosure)
}
