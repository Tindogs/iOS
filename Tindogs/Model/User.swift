import Foundation

final class User {
    var _id: String
    var firstName: String
    var lastName: String
    var email: String
    var userName: String
    var coordinates : [Double]? = nil
    var photo: String? = ""
    var dogs : [Dog]? = nil
    
    init(_id: String, firstName: String, lastName: String, email: String, userName: String) {
        self._id = _id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userName = userName
    }
    
    init(_id: String, firstName: String, lastName: String, email: String, userName: String, coordinates : [Double]?, photo: String?, dogs : [Dog]?){
        self._id = _id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userName = userName
        self.coordinates = coordinates
        self.photo = photo
        self.dogs = dogs
        
    }
}
