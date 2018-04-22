import UIKit

class RegisterViewController: UIViewController {
    
    var user: User?
    var pickedImage : UIImage?
    var photoName : String?
    let ActivityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showImagePickerButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        // check if there are empty fields
        if
            (firstNameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (userNameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (repeatPasswordTextField.text?.isEmpty)! {
            showAlert(message: "Rellena todos los campos por favor")
            return
        }
        
        // check if both passwords match
        if ((passwordTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true) {
            showAlert(message: "Las contraseñas no coinciden")
            return
        }
        
        // Show Activity Indicator
        self.showActivityIndicator()
        
        let registerUserInteractor: RegisterUserInteractor = RegisterUserInteractorImpl()
        let user = User(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, email: self.emailTextField.text!, userName: self.userNameTextField.text!, password: self.passwordTextField.text!, photo: "")
        
        // Check if there is an image selected
        if let image = pickedImage, let name = photoName {
            // So upload image
            let uploadImageInteractor: UploadImageInteractor = UploadImageInteractorImpl()
            uploadImageInteractor.save(name: name, image: image, onSuccess: { (url) in
                
                // If success Register user
                user.photo = url
                registerUserInteractor.execute(user: user, onSuccess: { (user: User) in
                    self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                    self.showAlertDismissVCAndNavigateToUserProfile(message: "Hola \(user.firstName), te has registrado correctamente")
                    self.user = user
                }) { (error: Error) in
                    self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                    self.showAlert(message: error.localizedDescription)
                }
                
            }, onError: { (error) in
                print("💩 error uploading image")
                self.showAlert(message: "Error durante el proceso de registro -profile photo upl err-" + (error.localizedDescription))
            })
        } else {
            
            // if there's no image selected register user without photo
            registerUserInteractor.execute(user: user, onSuccess: { (user: User) in
                self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                self.showAlertDismissVCAndNavigateToUserProfile(message: "Hola \(user.firstName), te has registrado correctamente")
                self.user = user
            }) { (error: Error) in
                self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    func showAlertDismissVCAndNavigateToUserProfile(message: String) {
        let alert = UIAlertController(title: "Guau Guau!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Vale", style: .destructive, handler: { (action) -> Void in
            // Destination VC
            let userProfileNavVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileNavigationViewController") as! UINavigationController
            
            // Reference to the nav's topVC to inyect the user property
            let userProfileVC = userProfileNavVC.topViewController as! UserProfileViewController
            userProfileVC.user = self.user
            
            // Set the rootvc to the destination vc with the appdelegate object
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.window?.rootViewController = userProfileNavVC
            
            // Dismiss current VC
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
