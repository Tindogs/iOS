
import Foundation

func UpdateDogRequest(userid: String, token: String, dog: Dog) -> URLRequest{
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.updateDogBByUserIdAndDogId.rawValue.replacingOccurrences(of: "XXX", with: userid).replacingOccurrences(of: "YYY", with: dog._id!))
    var request = URLRequest(url:url!)
    
    request.httpMethod = Method.PUT.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(token, forHTTPHeaderField: CONSTANTS.userDefaultsToken)
    

    var dictionary = [String:Any]()
    if dog.query != nil {
        dictionary = [
                       "queryage": dog.query!.age,
                    "querymaxkms": dog.query!.maxKms,
              "queryreproductive": dog.query!.reproductive,
                     "querybreed": dog.query!.breed
            ]
    } else {
        dictionary = [
            "name": dog.name,
            "age": dog.age!,
            "breed": dog.breed!,
            "purebreed": dog.pureBreed!,
            "color": dog.color!,
            "description": dog.description!,
            "likes_from_others": dog.likesFromOthers!,
            "photos": dog.photos!
        ]
    }
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    } catch {
        print("💩 Error serializing dictionary")
    }
    
    return request
}

