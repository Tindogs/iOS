//
//  ShowMatchesViewController.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 24/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

class ShowMatchesViewController: UIViewController {
    
    var user: User?
    var dog: Dog?
    var token: String?
    
    var matches: MatchesDecodable?
    
    override func viewDidLoad() {
        print("ShowMatchesViewController")
        
        let showMatchesInteractor: ShowMatchesInteractor = ShowMatchesInteractorImpl()
        
        showMatchesInteractor.execute(userId: (user?._id)!, dogId: (dog?._id)!, token: token!, onSuccess: { matches in
            self.matches = matches
            
            print("Matches \(matches)")
            
        }) { (error: Error) in
            print("Error \(error)")
        }
    }
}
