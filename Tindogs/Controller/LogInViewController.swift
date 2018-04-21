import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let ActivityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaults = UserDefaults.standard
        // there's a stored userid and token so we will navigate to the userprofile VC
        if let _id = defaults.string(forKey: "_id"), let token = defaults.string(forKey: "token") {
            self.showActivityIndicator()
            let getUserInteractor: GetUserInteractor = GetUserInteractorImpl()
            
            getUserInteractor.execute(userId: _id, token: token, onSuccess: { (user: User) in
                
                self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                
                // Destination VC
                let userProfileNavVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileNavigationViewController") as! UINavigationController
                
                // Reference to the nav's topVC to inyect the user property
                let userProfileVC = userProfileNavVC.topViewController as! UserProfileViewController
                userProfileVC.user = user
                
                // Set the rootvc to the destination vc with the appdelegate object
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.window?.rootViewController = userProfileNavVC
                
                // Dismiss current VC
                self.dismiss(animated: true, completion: nil)
                
            }, onError: { (error: Error) in
                self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                self.showAlert(message: error.localizedDescription )
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        // check if there are empty fields
        if
            (userNameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            showAlert(message: "Rellena todos los campos por favor")
            return
        }
        
        let loginUserInteractor: LoginUserInteractor = LoginUserInteractorImpl(loginVC: self)
        
        loginUserInteractor.execute(email: userNameTextField.text!, password: passwordTextField.text!, onSuccess: { (user: User, token: String) in
            self.hideActivityIndicator(activityIndicator: self.ActivityInd)
            
            if writeNSUserDefaults(_id: user._id!, token: token) != true {
                self.showAlert(message: "Error guardando las preferencias, revisa el espacio libre")
            }
            
            // Destination VC
            let userProfileNavVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileNavigationViewController") as! UINavigationController
            
            // Reference to the nav's topVC to inyect the user property
            let userProfileVC = userProfileNavVC.topViewController as! UserProfileViewController
            userProfileVC.user = user
            
            // Set the rootvc to the destination vc with the appdelegate object
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.window?.rootViewController = userProfileNavVC
            
            // Dismiss current VC
            self.dismiss(animated: true, completion: nil)
            
            self.userNameTextField.text = ""
            self.passwordTextField.text = ""
            
        }) { (error: Error) in
            self.hideActivityIndicator(activityIndicator: self.ActivityInd)
            self.showAlert(message: error.localizedDescription)
        }
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        print("forgotPasswor tapped")
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.present(registerVC, animated: true )
    }
    
    func showActivityIndicator() {
        ActivityInd.center = view.center
        ActivityInd.hidesWhenStopped = false
        ActivityInd.startAnimating()
        self.view.addSubview(ActivityInd)
    }
    
    
    func hideActivityIndicator(activityIndicator : UIActivityIndicatorView) {
        
        OperationQueue.main.addOperation {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Guau Guau! Grrr..", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Vale", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertAndDismissVC(message: String) {
        let alert = UIAlertController(title: "Guau Guau!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Vale", style: .destructive, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
