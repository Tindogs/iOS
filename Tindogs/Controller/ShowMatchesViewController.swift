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
    
    let userTemp = "5ad31151d4cdfa0504ccdd79"
    let dogIdTemp = "5acba449aa64ce3986f0948f"
    let tokenTemp = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YWQzMTE1MWQ0Y2RmYTA1MDRjY2RkNzkiLCJpYXQiOjE1MjQ1OTUxMjAsImV4cCI6MTUyNzE4NzEyMH0.ASgkKloYHOXnKf3UcMoxY168vSTykBJ2pZaTNQIipNE"
    
    var matches: MatchesDecodable?
    
    override func viewDidLoad() {
        print("ShowMatchesViewController")
        
        let showMatchesInteractor: ShowMatchesInteractor = ShowMatchesInteractorImpl()
        
        showMatchesInteractor.execute(userId: userTemp, dogId: dogIdTemp, token: tokenTemp, onSuccess: { matches in
            self.matches = matches
            
            print("Matches \(matches)")
            
        }) { (error: Error) in
            print("Error \(error)")
        }
    }
}
