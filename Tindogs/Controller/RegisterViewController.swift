import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        // Register to local NodeJS
        let url = URL(string: "http://localhost:3000/apiv1/users/register")
        var request = URLRequest(url:url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // fill dictionary
        let dictionary = [
            "first_name" : firstNameTextField.text!,
            "last_name"  : lastNameTextField.text!,
            "email"      : emailTextField.text!,
            "username"   : userNameTextField.text!,
            "password"   : passwordTextField.text!
            ] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        }  catch let error {
            print(error)
            showAlert(message: "💩 Error en la petición")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            self.hideActivityIndicator(activityIndicator: ActivityInd)
            
            if error != nil {
                print(error!)
                self.showAlert(message: "💩 Error en la respuesta")
                return
            }
        
                do {
                    //let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                    //let result = json["result"] as! [Dictionary<String, Any>]
                    if let parseJson = json {
                        if ((json?.value(forKey: "success") as! Bool) == true) {
                            
                            // TODO : EL TOKEN HABRA QUE GUARDARLO EN EL 
                            let token = json?.value(forKey: "token") as! String
                            let result = parseJson.object(forKey: "result") as! NSDictionary
                            
                            // TODO : MAPEO A OBJETOS, CUANTO TENGAMOS COREDATA
                            let first_name  = result.value(forKey: "first_name") as! String
                            let last_name   = result.value(forKey: "last_name") as! String
                            let email       = result.value(forKey: "email") as! String
                            let username    = result.value(forKey: "username") as! String
                            let coordinates = result.value(forKey: "coordinates") as! [Double]
                            let dogs        = result.value(forKey: "dogs") as! [Dog]
                            let _id         = result.value(forKey: "_id") as! String
                        }
                    }
            }
                catch {
                    self.hideActivityIndicator(activityIndicator: ActivityInd)
                    self.showAlert(message: "error parseando JSON")
                    print(error)
                }
            } // cierre clausura
        task.resume()
    } // cierre IBAction saveButton
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func hideActivityIndicator(activityIndicator : UIActivityIndicatorView) {
        
        DispatchQueue.main.async {
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

}
