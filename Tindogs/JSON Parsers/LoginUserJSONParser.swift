
import Foundation

func loginUserParseData (data: Data) -> (user:User, token: String) {
    
    var user: User?
    var dogs = [Dog]()
    var token : String?
    
    do {
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let jsontoken = json["token"] as? String,
            let result = json["result"] as? [String: Any] {
            token = jsontoken
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
                    let _id             = dog["_id"] as! String?
                    let name            = dog["name"] as! String
                    let age             = dog["age"] as! Int?
                    let breed           = dog["breed"] as! String?
                    let pureBreed       = dog["purebreed"] as! Bool?
                    let color           = dog["color"] as! String?
                    let query           = dog["query"] as! Query?
                    let likesFromOthers = dog["likes_from_others"] as! [LikesFromOthers]?
                    let description     = dog["description"] as! String?
                    let photos          = dog["photos"] as! [String]?
                    
                    dogs.append(Dog(_id: _id, name: name, age: age, breed: breed, pureBreed: pureBreed, color: color, query: query, likesFromOthers: likesFromOthers, description: description, photos: photos))
                }
                
                user = User(_id: _id, firstName: first_name, lastName: last_name, email: email, userName: username, password: password, coordinates: coordinates, photo: photo, dogs: dogs)
            }
        }
    } catch {
        print("💩 Error parsing RegisterUserJSONParser")
    }
    return (user!, token!)
}

