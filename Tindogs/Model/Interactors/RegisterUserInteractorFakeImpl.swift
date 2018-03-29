import Foundation

class RegisterUserInteractorFakeImpl : RegisterUserInteractor {

    func execute(firstName: String, lastName: String, email: String, userName: String, password: String, onSuccess: @escaping (User) -> Void) {
        execute(firstName: firstName, lastName: lastName, email: email, userName: userName, password: password, onSuccess: onSuccess, onError: nil)
    }
    
    func execute(firstName: String, lastName: String, email: String, userName: String, password: String, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
        let user = User(_id: "ifi341241212r", firstName: firstName, lastName: lastName, email: email, userName: userName, password: password, coordinates: nil, photo: nil, dogs: nil)
    
        OperationQueue.main.addOperation {
            onSuccess(user)
        }
    }
    
    
}
