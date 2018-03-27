import Foundation

protocol RegisterUserInteractor {
    func register(onSuccess: () -> Void, onError: () -> Void)
    
}
