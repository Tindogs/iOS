
import UIKit
import Firebase
import FirebaseStorage

class UploadImageInteractorImpl : UploadImageInteractor {
   
    func save(name: String, image: UIImage, onSuccess: @escaping (String) -> Void, onError: errorClosure?) {
        
        let imageReference = Storage.storage().reference().child("images/").child(name)
        
        if let imageData = UIImageJPEGRepresentation(image, 0.4) {
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            imageReference.putData(imageData, metadata: metadata, completion: { (metadata, error) in
                if let err = error, let retError = onError {
                    retError!(err)
                }
                
                if let m = metadata, let url = m.downloadURL() {
                    onSuccess(url.absoluteString)
                }
            })
        }
    }
    
}
