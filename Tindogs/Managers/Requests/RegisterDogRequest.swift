
import Foundation

func RegisterDogRequest(userid: String, token: String, dog: Dog) -> URLRequest{
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.addDogByUserId.rawValue.replacingOccurrences(of: "XXX", with: userid))
    var request = URLRequest(url:url!)
    
    request.httpMethod = Method.PUT.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(token, forHTTPHeaderField: CONSTANTS.userDefaultsToken)
    
    let dictionary = ["name": dog.name, "age": dog.age!, "breed": dog.breed!,"purebreed": dog.pureBreed!,"color": dog.color!, "description": dog.description!, "likes_from_others":[], "photos":dog.photos!, "query": []] as [String : Any]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    } catch {
        print("💩 Error serializing dictionary")
    }
    
    return request
}
