import Foundation

func RegisterUserRequest(user: User) -> URLRequest{
    
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.registerUser.rawValue)
    var request = URLRequest(url:url!)
    
    request.httpMethod = Method.POST.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    // fill dictionary
    let dictionary = ["first_name": user.firstName, "last_name": user.lastName, "email": user.email,"username": user.userName,"password": user.password, "photo": user.photo] as! [String: String]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    } catch {
        print("💩 Error serializing dictionary")
    }
    
    return request
}
