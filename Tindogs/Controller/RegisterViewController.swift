import UIKit

class RegisterViewController: UIViewController {
    
    var user: User?
    var pickedImage : UIImage?
    var photoName : String?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let ActivityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        ActivityInd.center = view.center
        ActivityInd.hidesWhenStopped = false
        ActivityInd.startAnimating()
        view.addSubview(ActivityInd)
        
        let registerUserInteractor: RegisterUserInteractor = RegisterUserInteractorImpl()
        var user = User(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, email: self.emailTextField.text!, userName: self.userNameTextField.text!, password: self.passwordTextField.text!, photo: "")
        
        // Check if there is an image selected
        if let image = pickedImage, let name = photoName {
            // So upload image
            let uploadImageInteractor: UploadImageInteractor = UploadImageInteractorImpl()
            uploadImageInteractor.save(name: name, image: image, onSuccess: { (url) in
                
                // If success Register user
                user.photo = url
                registerUserInteractor.execute(user: user, onSuccess: { (user: User) in
                    self.hideActivityIndicator(activityIndicator: ActivityInd)
                    self.showAlertAndDismissVC(message: "Hola \(user.firstName), te has registrado correctamente")
                    self.user = user
                }) { (error: Error) in
                    self.hideActivityIndicator(activityIndicator: ActivityInd)
                    self.showAlert(message: error as! String)
                }
                
            }, onError: { (error) in
                print("💩 error uploading image")
                self.showAlert(message: "Error durante el proceso de registro -profile photo upl err-" + (error as! String))
            })
        } else {
            
            // if there's no image selected register user without photo
            registerUserInteractor.execute(user: user, onSuccess: { (user: User) in
                self.hideActivityIndicator(activityIndicator: ActivityInd)
                self.showAlertAndDismissVC(message: "Hola \(user.firstName), te has registrado correctamente")
                self.user = user
            }) { (error: Error) in
                self.hideActivityIndicator(activityIndicator: ActivityInd)
                self.showAlert(message: error as! String)
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
