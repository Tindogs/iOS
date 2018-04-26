import Foundation

protocol RegisterUserInteractor {
    func execute(user: User ,onSuccess: @escaping (User, _ token: String) -> Void, onError: errorClosure)
}


