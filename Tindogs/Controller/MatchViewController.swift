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
    @IBOutlet weak var dogNameLabel: UILabel!
    
    var user: User?
    var dog: Dog?
    var token: String?
    
    var index: Int = 0
    var dogs: DogDecodable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show Activity Indicator
        let activityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        activityInd.center = view.center
        activityInd.hidesWhenStopped = false
        activityInd.startAnimating()
        view.addSubview(activityInd)
        
        let matchDogsInteractor: MatchDogsInteractor = MatchDogsInteractorImpl()
        
        matchDogsInteractor.execute(userId: (user?._id)!, dogId: (dog?._id)!, token: token!,
        onSuccess: { dogs in
            self.dogs = dogs
//            print("Dogs \(dogs.result[Int(self.randomNumber())].photos[0])")
            self.changeDogImage()
            
            
            self.hideActivityIndicator(activityIndicator: activityInd)
        }) { (error: Error) in
            print("Error: \(error)")
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
//        index=Int(self.randomNumber())
        index+=1
        print("Random Image \(index)")
        
        if ((self.dogs?.result.count)! > 0 && (self.dogs?.result[index].photos.count)!>0) {
            if let url = URL(string: (self.dogs?.result[index].photos[0])!) {
                self.randomMatchDogImage.contentMode = .scaleAspectFit
                self.downloadImage(url: url)
                self.dogNameLabel.text = self.dogs?.result[index].name
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
            .execute(userId: (user?._id)!,
                     dogId: (dog?._id)!,
                     token: token!,
                     otherDogId: otherDogId,
                     like: like,
                     onSuccess: { likes in
                        print("succes match: \(likes.result?.match)")
                        
//                        if (true) {
                        if (likes.result?.match) != nil {
                            if (like && (likes.result?.match)!) {
                                let matchedVC = self.storyboard?.instantiateViewController(withIdentifier: "MatchedViewController") as! MatchedViewController
                                
                                self.present(matchedVC, animated: true )
                            }
                        }
                        
                    }) { (error: Error) in
                        print("error \(error)")
                    }
    }
    
    func randomNumber() -> Int {
        print("self.dogs?.result.count: \(String(describing: self.dogs?.result.count))")
        
        if ((self.dogs?.result.count)!>0) {
            return Int(arc4random_uniform(UInt32((self.dogs?.result.count)!-1)))
        }else {
            return 0
        }
    }
}


