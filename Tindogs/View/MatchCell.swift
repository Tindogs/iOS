//
//  MatchCell.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 25/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit
import Kingfisher

class MatchCell: UICollectionViewCell {
    var dog: Dog?
    
    @IBOutlet weak var dogLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    
    func refresh(dog: Dog) {
        
        self.dog = dog
        self.dogLabel.text = dog.name
        if dog.photos?.isEmpty == false {
            self.dogImageView.kf.setImage(with: URL(string: dog.photos![0]))
        }
        
    }
}
