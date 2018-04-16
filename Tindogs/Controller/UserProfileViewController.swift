import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dogsCollectionView: UICollectionView!
    
    var user: User?
    var dogs: [Dog]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    let userProfileInteractor : UserProfileInteractor = UserProfileInteractorFakeImpl()
        
        userProfileInteractor.getUser(_id: "eresUnFistroPecador", token: "token", onSuccess: { (user: User) in
            // OK MACKEY
            self.user = user
            self.dogs = user.dogs
            
            self.dogsCollectionView.delegate = self
            self.dogsCollectionView.dataSource = self
        }) { (error: Error) in
            // KO MARAVILHAO
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


}
