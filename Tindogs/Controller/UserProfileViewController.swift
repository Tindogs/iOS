import UIKit

class UserProfileViewController: UIViewController {

    var user: User?
    var dogs: [Dog]?
    var token: String?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dogsCollectionView: UICollectionView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dogs = user?.dogs
        self.userNameLabel.text = user?.userName
        user?.photo?.loadImage(into: self.photoImageView)

        self.dogsCollectionView.delegate = self
        self.dogsCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dogsCollectionView.reloadData()
    }
    
    @IBAction func signOutButton(_ sender: Any) {
 
        deleteNSUserDefaults()
        
        // Destination VC
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
       
        // Set the rootvc to the destination vc with the appdelegate object
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window?.rootViewController = loginVC
        
        self.dismiss(animated: true, completion: nil)
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
        let dogVC = self.storyboard?.instantiateViewController(withIdentifier: "DogViewController") as! DogViewController
        
        dogVC.userId = self.user?._id
        dogVC.token  = self.token
        dogVC.transitionType = DogVCTransitionType.newDog
        
        self.present(dogVC, animated: true )
    }
}
