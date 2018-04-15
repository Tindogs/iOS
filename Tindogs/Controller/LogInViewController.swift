import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let ActivityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        // Show Activity Indicator
        
        ActivityInd.center = view.center
        ActivityInd.hidesWhenStopped = false
        ActivityInd.startAnimating()
        view.addSubview(ActivityInd)
        
        let loginUserInteractor: LoginUserInteractor = LoginUserInteractorImpl(loginVC: self)
        
        loginUserInteractor.execute(email: userNameTextField.text!, password: passwordTextField.text!, onSuccess: { (user: User, token: String) in
            self.hideActivityIndicator(activityIndicator: self.ActivityInd)
            
            if writeNSUserDefaults(_id: user._id!, token: token) != true {
                self.showAlert(message: "Error guardando las preferencias, revisa el espacio libre")
            }
            
            let userProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
            
            self.present(userProfileVC, animated: true)
            
            self.userNameTextField.text = ""
            self.passwordTextField.text = ""
            
        }) { (error: Error) in
            self.hideActivityIndicator(activityIndicator: self.ActivityInd)
            self.showAlert(message: error as! String)
        }
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        print("forgotPasswor tapped")
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.present(registerVC, animated: true )
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
