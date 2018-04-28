
import UIKit
import Kingfisher

class DogCell: UICollectionViewCell {
    var dog: Dog?
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogLabel: UILabel!
    
    func refresh(dog: Dog) {
        
        self.dog = dog
        self.dogLabel.text = dog.name
        if dog.photos?.isEmpty == false {
            self.dogImageView.kf.setImage(with: URL(string: dog.photos![0]))
        }
        
    }
}
