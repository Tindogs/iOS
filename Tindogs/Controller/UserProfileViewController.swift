import UIKit
import CoreLocation

class UserProfileViewController: UIViewController, CLLocationManagerDelegate {

    var user: User?
    var dogs: [Dog]?
    var token: String?
    let locationManager = CLLocationManager()
    
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
        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.dogsCollectionView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDogQueryVCSegue" {
            let vc = segue.destination as! DogQueryPreferencesViewController
            let indexPath = self.dogsCollectionView.indexPathsForSelectedItems![0]
            vc.user = self.user
            vc.dog = self.dogs?[indexPath.row]
            vc.token = self.token
            vc.title = self.dogs?[indexPath.row].name
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.locationManager.stopUpdatingLocation()
        
        let updateLocationInteractor: UpdateLocationInteractor = UpdateLocationInteractorImpl()
        
        updateLocationInteractor.execute(userid: (self.user?._id)!, token: self.token!, coordinates: [locValue.longitude, locValue.latitude]) { (error: Error) in
            self.showAlert(message: error.localizedDescription)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Guau Guau! Grrr..", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Vale", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
