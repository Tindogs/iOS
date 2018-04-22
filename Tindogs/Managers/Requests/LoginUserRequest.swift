
import Foundation

func LoginUserRequest(email: String, password: String) -> URLRequest{
    
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.authenticate.rawValue)
    var request = URLRequest(url:url!)
    
    request.httpMethod = Method.POST.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    // fill dictionary
    let dictionary = ["email": email, "password": password] 
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    } catch {
        print("💩 Error serializing dictionary")
    }
    
    return request
}
