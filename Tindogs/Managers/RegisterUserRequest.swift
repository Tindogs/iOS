import Foundation

func RegisterUserRequest(firstName: String, lastName: String, email: String, userName: String, password: String) -> URLRequest{
    
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.registerUser.rawValue)
    var request = URLRequest(url:url!)
    
    request.httpMethod = Method.POST.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    // fill dictionary
    let dictionary = ["first_name": firstName, "last_name": lastName, "email": email,"username": userName,"password": password] as [String: String]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    } catch {
        print("💩 Error serializing dictionary")
    }
    
    return request
}
