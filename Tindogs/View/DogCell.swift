
import UIKit

class DogCell: UICollectionViewCell {
    var dog: Dog?
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogLabel: UILabel!
    
    func refresh(dog: Dog) {
        self.dog = dog
        self.dogLabel.text = dog.name
        if dog.photos?.isEmpty == false {
            dog.photos![0].loadImage(into: self.dogImageView)
            print(dog.photos![0])
        }
    }
}
