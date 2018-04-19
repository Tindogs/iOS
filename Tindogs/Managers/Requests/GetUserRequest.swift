
import Foundation

func getUserRequest(userId: String, token: String) -> URLRequest {
    
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.findOrUpdateUser.rawValue + userId)
    var request = URLRequest (url:url!)
    
    request.httpMethod = Method.GET.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let dictionary = ["token": token]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    } catch {
        print("💩 Error serializing dictionary")
    }
    
    return request
}
