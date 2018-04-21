
import Foundation

class UserProfileInteractorImpl: UserProfileInteractor {
    
    func getUser(user: User, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
 
        print(user.userName)
        var dogs = [AnyObject]()
        
        for dog in user.dogs! {
            let dog = Dog(_id: dog._id, name: dog.name, age: dog.age, breed: dog.breed, pureBreed: dog.pureBreed, color: dog.color, query: dog.query, likesFromOthers: dog.likesFromOthers, description: dog.description, photos: dog.photos)
            dogs.append(dog)
        }

        let user = User(_id: user._id, firstName: user.firstName, lastName: user.lastName, email: user.email, userName: user.userName, password: user.password, coordinates: user.coordinates, photo: user.photo, dogs: dogs as? [Dog])
        
        OperationQueue.main.addOperation {
            onSuccess(user)
        }
    }
}


