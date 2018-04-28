//
//  ShowMatchesViewController.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 24/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit
import Kingfisher

class ShowMatchesViewController: UIViewController {
    
    var idDogMatched: String?
    var idUserDogMatched: String?
    var token: String?
    
    @IBOutlet weak var MatchedDogImage: UIImageView!
    
    @IBOutlet weak var matchedDogName: UILabel!
    @IBOutlet weak var matchedDogAge: UILabel!
    @IBOutlet weak var matchedDogBreed: UILabel!
    @IBOutlet weak var matchedDogColor: UILabel!
    @IBOutlet weak var matchedDogDescription: UILabel!
    
    var dogs: DogDecodable?
    
    override func viewDidLoad() {
        print("ShowMatchesViewController")
        
        let matchDetailInteractor: MatchedDetailInteractor = MatchedDetailInteractorImpl()
        
        matchDetailInteractor.execute(userId: idUserDogMatched!,
                                      dogId: idDogMatched!,
                                      token: token!,
                                    onSuccess: { dogs in
                                        self.dogs = dogs
                                        print("Dogs \(dogs.result[0].photos[0])")
                                        
                                        self.MatchedDogImage.kf.setImage(with: URL(string: (self.dogs?.result[0].photos[0])!))
//                                        if let url = URL(string: (self.dogs?.result[0].photos[0])!) {
//                                            //self.downloadImage(url: url)
//                                            self.downloadImageKF(url: url)
//                                        }
                                        self.matchedDogName.text = dogs.result[0].name
                                        self.matchedDogAge.text = "Edad: \(dogs.result[0].age!)"
                                        self.matchedDogBreed.text = "Raza: \(dogs.result[0].breed!)"
                                        self.matchedDogColor.text = "Color: \(dogs.result[0].color!)"
                                        self.matchedDogDescription.text =  dogs.result[0].description
                                        
        }) { (error: Error) in
            print("Error: \(error)")
        }
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
                self.MatchedDogImage.image = UIImage(data: data)
            }
        }
    }
    
}
