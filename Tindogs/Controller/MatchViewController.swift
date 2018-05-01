//
//  MatchViewController.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit
import Kingfisher

class MatchViewController: UIViewController {
    
    @IBOutlet weak var randomMatchDogImage: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    
    var user: User?
    var dog: Dog?
    var token: String?
    
    // Show Activity Indicator
    let activityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var index: Int = 0
    var dogs: DogDecodable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityInd.center = view.center
        self.activityInd.hidesWhenStopped = false
        self.activityInd.startAnimating()
        view.addSubview(activityInd)
        
        
        if let _user = user, let _dog = dog ,let userId = _user._id, let dogId = _dog._id, let token = token {
            let matchDogsInteractor: MatchDogsInteractor = MatchDogsInteractorImpl(MatchVC: self)
        
            matchDogsInteractor.execute(userId: userId, dogId: dogId, token: token,
            onSuccess: { dogs in
                self.dogs = dogs
    //            print("Dogs \(dogs.result[Int(self.randomNumber())].photos[0])")
                self.changeDogImage()
                
                
                self.hideActivityIndicator(activityIndicator: self.activityInd)
            }) { (error: Error) in
                print("Error: \(error)")
                self.hideActivityIndicator(activityIndicator: self.activityInd)
                self.showAlert(message: error as! String)
            }
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
    
    @IBAction func likeButton(_ sender: Any) {
        self.doLikeDislike(like: true)
        self.changeDogImage()
    }
    
    @IBAction func dontLikeButton(_ sender: Any) {
        self.doLikeDislike(like: false)
        self.changeDogImage()
    }
    
    func changeDogImage(){
//        index=Int(self.randomNumber())
        index+=1
        print("Random Image \(index)")
        
        if let dogs = self.dogs {
            if ((dogs.result.count) > 0 && (dogs.result[index].photos.count)>0) {
                if let url = URL(string: (dogs.result[index].photos[0])) {
                    self.randomMatchDogImage.contentMode = .scaleAspectFit
                    self.randomMatchDogImage.kf.setImage(with: url)
                    self.dogNameLabel.text = dogs.result[index].name
                }
            }else{
                print("No Image")
            }
        }
        
        
    }
    
    func doLikeDislike(like: Bool) {
        let matchDogsLikeInteractor: MatchDogsLikeInteractor = MatchDogsLikeInteractorImpl(MatchVC: self)
        var otherDogId = ""
        
        if let dogs = self.dogs {
            if ((dogs.result.count) > 0 && (dogs.result[index].photos.count)>0) {
                otherDogId = (dogs.result[self.index]._id)
            }
        }
        
        if let user = user, let userId = user._id, let dog = dog, let dogId = dog._id, let token = token {
            matchDogsLikeInteractor
                .execute(userId: userId,
                         dogId: dogId,
                         token: token,
                         otherDogId: otherDogId,
                         like: like,
                         onSuccess: { likes in
                            print("succes match: \(String(describing: likes.result?.match))")
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
    }
    
    func randomNumber() -> Int {
        
        guard let dogs = self.dogs else {return 0}
        print("dogs.result.count: \(String(describing: dogs.result.count))")
        
        if ((dogs.result.count)>0) {
            return Int(arc4random_uniform(UInt32((dogs.result.count)-1)))
        }else {
            return 0
        }
    }
}


