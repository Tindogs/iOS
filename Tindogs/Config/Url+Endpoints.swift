import Foundation

let baseUrl: String = "http://localhost:3000/apiv1/"

enum Method: String {
    case GET  = "GET"
    case PUT  = "PUT"
    case POST = "POST"
}

enum EndPoints: String {
    case findOrUpdateUser       = "users/"
    case registerUser           = "users/register/"
    case authenticate           = "users/autenthicate"
    case findDogsFromUser       = "dogs/fromuser/"
    case addOrUpdateDogByUserId = "dogs/withuser/"
}
