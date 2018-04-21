
import Foundation

func getUserRequest(userId: String, token: String) -> URLRequest {
    
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.findOrUpdateUser.rawValue + userId)
    var request = URLRequest (url:url!)
    
    request.httpMethod = Method.GET.rawValue
    request.addValue(token, forHTTPHeaderField: CONSTANTS.userDefaultsToken)
    
    return request
}
