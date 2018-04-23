
import UIKit

class DogQueryPreferencesViewController: UIViewController {
        
    var user: User?
    var dog: Dog?
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDogLikesMatchesVCSegue" {
            let vc = segue.destination as! MatchViewController
            vc.user = self.user
            vc.dog = self.dog
            vc.token = self.token
            
        }
    }
}
