import Foundation

final class User {
    let _id: String
    let firstName: String
    let lastName: String
    let email: String
    let userName: String
    let coordinates : [Double]?
    let photo: String?
    let dogs : [Dog]?
    
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
