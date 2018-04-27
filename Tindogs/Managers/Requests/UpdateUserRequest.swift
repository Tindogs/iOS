
import Foundation

func updateUserRequest (user: User, token: String) -> URLRequest{
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.findOrUpdateUser.rawValue + "\(user._id!)")
    var request = URLRequest(url:url!)
    var dictionary: [String:String]
    
    request.httpMethod = Method.PUT.rawValue
    request.addValue(token, forHTTPHeaderField: CONSTANTS.userDefaultsToken)
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    if user.photo != "" {
        dictionary = ["first_name": user.firstName, "last_name": user.lastName, "email": user.email,"username": user.userName, "photo": user.photo] as! [String: String]
    } else {
        dictionary = ["first_name": user.firstName, "last_name": user.lastName, "email": user.email,"username": user.userName]
    }
    
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    } catch {
        print("💩 Error serializing dictionary")
    }
    
    return request
}
