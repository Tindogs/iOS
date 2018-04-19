import Foundation

protocol GetUserInteractor {
    func execute(userId: String, token: String ,onSuccess: @escaping (User) -> Void, onError: errorClosure)
}
