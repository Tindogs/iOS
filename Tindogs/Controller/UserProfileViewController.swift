import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dogsCollectionView: UICollectionView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var user: User?
    var dogs: [Dog]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    let userProfileInteractor : UserProfileInteractor = UserProfileInteractorFakeImpl()
        
        userProfileInteractor.getUser(_id: "eresUnFistroPecador", token: "token", onSuccess: { (user: User) in
            // OK MACKEY
            self.user = user
            self.dogs = user.dogs
            self.userNameLabel.text = user.userName
            user.photo?.loadImage(into: self.photoImageView)
            
            self.dogsCollectionView.delegate = self
            self.dogsCollectionView.dataSource = self
        }) { (error: Error) in
            // KKO MARAVILHAO
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        deleteNSUserDefaults()
    }

    @IBAction func matchButton(_ sender: Any) {
        print("matchButton tapped")
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        print("settingsButton tapped")
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
        print("editProfileButton tapped")
    }
    
    @IBAction func newDogButton(_ sender: Any) {
        print("newDogButton tapped")
    }
}
