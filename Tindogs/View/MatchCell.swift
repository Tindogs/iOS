//
//  MatchCell.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 25/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

class MatchCell: UICollectionViewCell {
    var dog: Dog?
    
    @IBOutlet weak var dogLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    
    func refresh(dog: Dog) {
        self.dog = dog
        self.dogLabel.text = dog.name
        if dog.photos?.isEmpty == false {
            dog.photos![0].loadImage(into: self.dogImageView)
        }
    }
}
