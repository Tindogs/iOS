//
//  MatchDogsLikeInteractorImpl.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

class MatchDogsLikeInteractorImpl: MatchDogsLikeInteractor {
    func execute(userId: String, dogId: String, token: String, otherDogId: String, like: Bool, onSuccess: @escaping () -> Void, onError: errorClosure) {
        
        let request: URLRequest = MatchDogsLikeRequest(userId: userId, dogId: dogId, token: token, otherDogId: otherDogId, like: like)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            OperationQueue.main.addOperation{
                if error == nil {
                    
                    do {
                        if let data = data {
                            let json = try? JSONSerialization.jsonObject(with: data, options: [])
                            
                            print(json ?? "Nothing")
                        }
                    }catch{
                        print("error: \(String(describing: error))")
                    }
                    
                } else {
                    if let onError = onError{
                        onError(error!)
                    }
                }
            }
        }
        task.resume()
    }    
}
