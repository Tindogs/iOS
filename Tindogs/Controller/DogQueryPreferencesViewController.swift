
import UIKit

class DogQueryPreferencesViewController: UIViewController {
        
    var user: User?
    var dog: Dog?
    var token: String?
    var query: Query?
    
    var pickedBreed: String?
    let rowHeight : CGFloat = 20.0
    let ActivityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var maxKmsTextField: UITextField!
    @IBOutlet weak var reproductiveSwitch: UISwitch!
    @IBOutlet weak var breedPicker: UIPickerView!
    @IBOutlet weak var matchesCollectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.breedPicker.delegate = self
        self.breedPicker.dataSource = self
        
        editModeOff()

        if self.dog?.photos?.isEmpty == false {
            self.dog?.photos?[0].loadImage(into: self.photoImageView)
        }
        
        if let query: Query = dog?.query {
            self.ageTextField.text = String(query.age)
            self.maxKmsTextField.text = String(query.maxKms)
            self.reproductiveSwitch.isOn = query.reproductive
            let index = BREEDS.values.index(of: query.breed) ?? 0
            pickedBreed = query.breed
            self.breedPicker.selectRow(index, inComponent: 0, animated: false)
        }

    }
    
    @IBAction func editButton(_ sender: Any) {
        editModeOn()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if
            (ageTextField.text?.isEmpty)! || (maxKmsTextField.text?.isEmpty)! || (pickedBreed == nil) || (pickedBreed == "") {
            showAlert(message: "Rellena todos los campos por favor")
            return
        }
        
        query = Query(age: Int(self.ageTextField.text!)!, maxKms: Int(self.maxKmsTextField.text!)!, reproductive: self.reproductiveSwitch.isOn, breed: self.pickedBreed!)
        self.dog?.query = query
        
        self.showActivityIndicator()
        let updateDogInteractor: UpdateDogInteractor = UpdateDogInteractorImpl()
        updateDogInteractor.execute(userid: (self.user?._id)!, token: self.token!, dog: self.dog!, onSuccess: { (user: User) in
            self.hideActivityIndicator(activityIndicator: self.ActivityInd)
            self.showAlert(message: "Las preferencias de \(self.dog?.name ?? "tu perrete") se han guardado correctamente!")
        }) { (error: Error) in
            self.hideActivityIndicator(activityIndicator: self.ActivityInd)
            self.showAlert(message: error.localizedDescription )
        }
        
        
        editModeOff()
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
    
    func editModeOff() {
        self.ageTextField.isEnabled = false
        self.ageTextField.backgroundColor = UIColorFromHex(rgbValue: 0xe6e6e6, alpha: 1.0)
        self.maxKmsTextField.isEnabled = false
        self.maxKmsTextField.backgroundColor = UIColorFromHex(rgbValue: 0xe6e6e6, alpha: 1.0)
        self.reproductiveSwitch.isEnabled = false
        self.reproductiveSwitch.backgroundColor = UIColorFromHex(rgbValue: 0xe6e6e6, alpha: 1.0)
        self.breedPicker.isUserInteractionEnabled = false
        self.breedPicker.backgroundColor = UIColorFromHex(rgbValue: 0xe6e6e6, alpha: 1.0)
        self.saveButton.isEnabled = false
    }

    func editModeOn() {
        self.ageTextField.isEnabled = true
        self.ageTextField.backgroundColor = UIColor.white
        self.maxKmsTextField.isEnabled = true
        self.maxKmsTextField.backgroundColor = UIColor.white
        self.reproductiveSwitch.isEnabled = true
        self.reproductiveSwitch.backgroundColor = UIColor.white
        self.breedPicker.isUserInteractionEnabled = true
        self.breedPicker.backgroundColor = UIColor.white
        self.saveButton.isEnabled = true
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Guau Guau! Grrr..", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Vale", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDogLikesMatchesVCSegue" {
            let vc = segue.destination as! MatchViewController
            vc.user  = self.user
            vc.dog   = self.dog
            vc.token = self.token
        }
    }
}
