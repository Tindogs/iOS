import Foundation

struct CONSTANTS {
    static let BASEURL: String = "http://34.239.83.44:3000/apiv1/"
    static let userDefaults_id: String = "_id"
    static let userDefaultsToken: String = "token"
}

enum DogVCTransitionType  {
    case updateDog
    case newDog
}

enum Method: String {
    case GET  = "GET"
    case PUT  = "PUT"
    case POST = "POST"
}

enum EndPoints: String {
    case findOrUpdateUser           = "users/"
    case registerUser               = "users/register/"
    case authenticate               = "users/authenticate"
    case findDogsFromUser           = "dogs/fromuser/"
    case addDogByUserId             = "users/XXX/dogs"
    case updateDogBByUserIdAndDogId = "users/XXX/dogs/YYY"
}
