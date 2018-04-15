import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        let defaults = UserDefaults.standard
        
//        print("-------------------BEFORE-------------------")
//        print (defaults.string(forKey: CONSTANTS.userDefaults_id))
//        print (defaults.string(forKey: CONSTANTS.userDefaultsToken))
        
        defaults.removeObject(forKey:CONSTANTS.userDefaults_id)
        defaults.removeObject(forKey:CONSTANTS.userDefaultsToken)
        
//        print("-------------------AFTER-------------------")
//        print (defaults.string(forKey: CONSTANTS.userDefaults_id))
//        print (defaults.string(forKey: CONSTANTS.userDefaultsToken))
    }
    
    @IBAction func daleButton(_ sender: Any) {
    }


}
