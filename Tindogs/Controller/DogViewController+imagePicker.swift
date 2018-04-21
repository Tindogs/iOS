
import UIKit


extension DogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.photoImageView.contentMode = .scaleAspectFit
                self.photoImageView.image = pickedImage
                self.photoName = "\(UUID().uuidString).jpg"
                self.pickedImage = pickedImage
            }
        })
    }
}

