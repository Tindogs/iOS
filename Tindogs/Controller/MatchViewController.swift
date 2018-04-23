//
//  MatchViewController.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {
    
    @IBOutlet weak var randomMatchDogImage: UIImageView!
    
    var user: User?
    var index: Int = 1
    var dogs: DogDecodable?
    
    // User data
    
    var userTemp = "5ad31151d4cdfa0504ccdd79" // El id dueño del perro que pincho
    var dogIdTemp = "5acba449aa64ce3986f0948f" // el id del perro que pincho
    var tokenTemp =                             "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YWQzMTE1MWQ0Y2RmYTA1MDRjY2RkNzkiLCJpYXQiOjE1MjQzODE3MzksImV4cCI6MTUyNDQ2ODEzOX0.PnTMfjXv1Qd7szI4lhM1bCU5bhGBTuhyNklzLB-R8a8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show Activity Indicator
        let activityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        activityInd.center = view.center
        activityInd.hidesWhenStopped = false
        activityInd.startAnimating()
        view.addSubview(activityInd)
        
        let matchDogsInteractor: MatchDogsInteractor = MatchDogsInteractorImpl()
        
        matchDogsInteractor.execute(userId: userTemp, dogId: dogIdTemp, token: tokenTemp,
        onSuccess: { dogs in
            self.dogs = dogs
            print("Dogs \(dogs.result[Int(self.randomNumber())].photos[0])")
            self.changeDogImage()
            
            self.hideActivityIndicator(activityIndicator: activityInd)
        }) { (error: Error) in
            self.hideActivityIndicator(activityIndicator: activityInd)
            self.showAlert(message: error as! String)
        }
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
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.randomMatchDogImage.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func likeButton(_ sender: Any) {
        self.changeDogImage()
        self.doLikeDislike(like: true)
    }
    
    @IBAction func dontLikeButton(_ sender: Any) {
        self.changeDogImage()
        self.doLikeDislike(like: false)
    }
    
    func changeDogImage(){
        index=Int(self.randomNumber())
        print("Random Image \(index)")
        
        if ((self.dogs?.result.count)! > 0 && (self.dogs?.result[index].photos.count)!>0) {
            if let url = URL(string: (self.dogs?.result[index].photos[0])!) {
                self.randomMatchDogImage.contentMode = .scaleAspectFit
                self.downloadImage(url: url)
            }
        }else{
            print("No Image")
        }
    }
    
    func doLikeDislike(like: Bool) {
        let matchDogsLikeInteractor: MatchDogsLikeInteractor = MatchDogsLikeInteractorImpl()
        var otherDogId = ""
        
        if ((self.dogs?.result.count)! > 0 && (self.dogs?.result[index].photos.count)!>0) {
            otherDogId = (dogs?.result[self.index]._id)!
        }
        
        matchDogsLikeInteractor
            .execute(userId: userTemp,
                     dogId: dogIdTemp,
                     token: tokenTemp,
                     otherDogId: otherDogId,
                     like: like,
                     onSuccess: {
                        print("succes")
                    }) { (error: Error) in
                        print("error \(error)")
                    }
    }
    
    func randomNumber() -> Int {
        print("self.dogs?.result.count: \(String(describing: self.dogs?.result.count))")
        return Int(arc4random_uniform(UInt32((self.dogs?.result.count)!-1)))
    }
}


