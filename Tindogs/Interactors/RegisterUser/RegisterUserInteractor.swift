import Foundation

protocol RegisterUserInteractor {
    func execute(user: User ,onSuccess: @escaping (User) -> Void, onError: errorClosure)
}


