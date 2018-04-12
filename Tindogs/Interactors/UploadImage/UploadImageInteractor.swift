
import Foundation
import UIKit

protocol UploadImageInteractor {
    
    func save(name: String, image: UIImage, onSuccess: @escaping (_ url: String) -> Void, onError: errorClosure?)
    
}
