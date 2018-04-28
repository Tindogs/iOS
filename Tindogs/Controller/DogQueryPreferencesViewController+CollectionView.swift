//
//  DogQueryPreferencesViewController+CollectionView.swift
//  Tindogs
//
//  Created by Fabio Gomez on 23/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

extension DogQueryPreferencesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let matches: MatchesDecodable = matches {
            return matches.result.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MatchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCell", for: indexPath) as! MatchCell
        
        let match = self.matches?.result[indexPath.row]
        let matchName = ((match?.name_dog_matched) != nil) ? match?.name_dog_matched : "SinNombre"
        let dog: Dog = Dog(_id: match?.id_dog_matched, name: matchName!, age: 0, breed: "", pureBreed: false, color: "", query: nil, likesFromOthers: [], description: "", photos: [(match?.img_dog_matched)!])
        
        cell.refresh(dog: dog)
        
        return cell
    }
}
