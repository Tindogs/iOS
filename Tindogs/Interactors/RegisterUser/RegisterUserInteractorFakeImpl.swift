import Foundation

class RegisterUserInteractorFakeImpl : RegisterUserInteractor {
    func execute(user: User, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        let user = User(_id: "ifi341241212r", firstName: user.firstName, lastName: user.lastName, email: user.email, userName: user.userName, password: user.password, coordinates: nil, photo: nil, dogs: nil)
        
        OperationQueue.main.addOperation {
            onSuccess(user)
        }
    }
}

