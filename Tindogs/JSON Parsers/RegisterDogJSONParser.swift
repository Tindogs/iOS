
import Foundation

func registerDogParseData (data: Data) -> User {
    var user: User?
    var dogs = [Dog]()
    var query: Query?
    var likesFromOthers = [LikesFromOthers]()
    var photos = [String]()
    
    do {
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let result = json["result"] as? [String: Any] {
            let _id         = result["_id"] as! String?
            let first_name  = result["first_name"] as! String
            let last_name   = result["last_name"] as! String
            let email       = result["email"] as! String
            let username    = result["username"] as! String
            let password    = result["password"] as! String
            let coordinates = result["coordinates"] as! [Double]?
            let photo       = result["photo"] as! String?
            if let dogsDict = result["dogs"] as? [[String: Any]] {
                for dog in dogsDict {
                    let _id              = dog["_id"] as! String?
                    let name             = dog["name"] as! String
                    let age              = dog["age"] as! Int?
                    let breed            = dog["breed"] as! String?
                    let pureBreed        = dog["purebreed"] as! Bool?
                    let color            = dog["color"] as! String?
                    if let queryDict     = dog["query"] as? [String:Any]{
                        let age          = queryDict["age"] as! Int
                        let breed        = queryDict["breed"] as! String
                        let reproductive = queryDict["reproductive"] as! Bool
                        let max_kms      = queryDict["max_kms"] as! Int
                        query = Query(age: age, maxKms: max_kms, reproductive: reproductive, breed: breed)
                    }
                    if let likesFromOthersArr = dog["likes_from_others"] as? [[String: String]]{
                        for like in likesFromOthersArr {
                            let dogLikeId   = like["dog_like_id"] as String?
                            let dogName     = like["dog_name"] as String?
                            let ownerId     = like["owner_id"] as String?
                            likesFromOthers.append(LikesFromOthers(dogLikeId: dogLikeId!, dogName: dogName!, ownerId: ownerId!))
                        }
                    }
                    let description     = dog["description"] as! String?
                    if let photosArr    = dog["photos"] as? [String]{
                        for i in photosArr {
                            photos.append(i)
                        }
                    }
                    dogs.append(Dog(_id: _id, name: name, age: age, breed: breed, pureBreed: pureBreed, color: color, query: query, likesFromOthers: likesFromOthers, description: description, photos: photos))
                    query = nil
                    likesFromOthers = [LikesFromOthers]()
                    photos = [String]()
                }
                user = User(_id: _id, firstName: first_name, lastName: last_name, email: email, userName: username, password: password, coordinates: coordinates, photo: photo, dogs: dogs)
                dogs = [Dog]()
            }
        }
    } catch {
        print("💩 error parsing registerDogParseData")
    }
    return user!
}
