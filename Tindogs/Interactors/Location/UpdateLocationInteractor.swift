
import Foundation

protocol UpdateLocationInteractor {
    func execute(userid: String, token: String, coordinates : [Double] , onError: errorClosure)
}
