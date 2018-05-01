
import UIKit
import Kingfisher

class DogCell: UICollectionViewCell {
    var dog: Dog?
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogLabel: UILabel!
    
    func refresh(dog: Dog) {
        
        self.dog = dog
        self.dogLabel.text = dog.name
        guard let photos = dog.photos else {return}
        if photos.isEmpty == false {
            self.dogImageView.kf.setImage(with: URL(string: photos[0]))
        }
        
    }
}
