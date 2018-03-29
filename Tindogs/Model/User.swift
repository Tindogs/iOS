import Foundation

final class User {
    let _id: String?
    let firstName: String
    let lastName: String
    let email: String
    let userName: String
    let password: String
    var coordinates : [Double]?
    var photo: String?
    var dogs : [Dog]?
    
    init(_id: String?, firstName: String, lastName: String, email: String, userName: String, password: String , coordinates : [Double]?, photo: String?, dogs : [Dog]?){
        self._id = _id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userName = userName
        self.password = password
        self.coordinates = coordinates
        self.photo = photo
        self.dogs = dogs
    }
    
    convenience init(firstName: String, lastName: String, email: String, userName: String, password: String) {
        self.init(_id: "", firstName: firstName, lastName: lastName, email: email, userName: userName, password: password, coordinates : [], photo: "", dogs : [])
    }
}

extension User {
    func addDog(dog: Dog) {
        self.dogs?.append(dog)
    }
}

extension User {
    func addCoordinates(coordinates: [Double]) {
        self.coordinates? = coordinates
    }
}
