
import UIKit

class DogCell: UICollectionViewCell {
    var dog: Dog?
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogLabel: UILabel!
    
    func refresh(dog: Dog) {
        self.dog = dog
        self.dogLabel.text = dog.name
        // TODO Image View
        
    }
}
