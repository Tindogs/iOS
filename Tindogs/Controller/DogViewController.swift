import UIKit

class DogViewController: UIViewController {
    
    var user: User?
    var dog: Dog?
    var token: String?
    var userId: String?
    var dogId: String?
    var transitionType: DogVCTransitionType?
    
    var pickedBreed: String?
    var pickedImage : UIImage?
    var photoName : String?
    let rowHeight : CGFloat = 20.0
    let ActivityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var purebreedSwitch: UISwitch!
    @IBOutlet weak var breedPicker: UIPickerView!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.breedPicker.delegate = self
        self.breedPicker.dataSource = self
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
            (nameTextField.text?.isEmpty)! || (ageTextField.text?.isEmpty)! || (pickedBreed == nil) || (pickedBreed == "") || (colorTextField.text?.isEmpty)! || (descriptionTextField.text?.isEmpty)!{
            showAlert(message: "Rellena todos los campos por favor")
            return
        }
        
        // Show Activity Indicator
        self.showActivityIndicator()

        let registerDogInteractor: RegisterDogInteractor = RegisterDogInteractorImpl()
        let dog = Dog(name: self.nameTextField.text!, age: Int(self.ageTextField.text!)!, breed: self.pickedBreed!, pureBreed: self.purebreedSwitch.isOn, color: self.colorTextField.text!, description: self.descriptionTextField.text!, photos:[])
        
        switch transitionType! {
        case DogVCTransitionType.newDog:
             // AÑADIR PERRETE CON FOTO
            if let image = pickedImage, let name = photoName {
                let uploadImageInteractor: UploadImageInteractor = UploadImageInteractorImpl()
                uploadImageInteractor.save(name: name, image: image, onSuccess: { (url) in
                    dog.photos?.append(url)
                    registerDogInteractor.execute(userid: self.userId!, token: self.token!, dog: dog, onSuccess: { (user: User) in
                        self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                        self.showAlertDismissVCAndNavigateToUserProfile(message: "\(dog.name) registrado correctamente")
                        self.user = user
                    }, onError: { (error: Error) in
                        self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                        self.showAlert(message: error.localizedDescription)
                    })
                }, onError: { (error) in
                    print("💩 error uploading image")
                    self.showAlert(message: "Error durante el proceso de registro -dog photo upl err-" + (error.localizedDescription))
                })                
            } else {
                 // AÑADIR PERRETE SIN FOTO
                registerDogInteractor.execute(userid: self.userId!, token: self.token!, dog: dog, onSuccess: { (user: User) in
                    self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                    self.showAlertDismissVCAndNavigateToUserProfile(message: "\(dog.name) registrado correctamente")
                    self.user = user
                }, onError: { (error: Error) in
                    self.hideActivityIndicator(activityIndicator: self.ActivityInd)
                    self.showAlert(message: error.localizedDescription)
                })
            }
        case DogVCTransitionType.updateDog: // ACTUALIZAR PERRETE
            print (transitionType!)
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
            userProfileVC.token = self.token
            
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
