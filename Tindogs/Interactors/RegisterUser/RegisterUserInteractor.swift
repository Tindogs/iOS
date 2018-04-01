import Foundation

protocol RegisterUserInteractor {
    func execute(user: User ,onSuccess: @escaping (User) -> Void, onError: errorClosure)

    // En la implementación Deberia ejecutar una funcion de url endpoints que registrara el usuario y
    // debería devolver bien un error, bien el objeto de core data usuario ya creado
    // La funcion además de parsear deberia mapear a objetos core data.
}


