//
//  MatchDogsLikeInteractorImpl.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

class MatchDogsLikeInteractorImpl: MatchDogsLikeInteractor {
    
    let MatchVC: MatchViewController
    
    init(MatchVC: MatchViewController){
        self.MatchVC = MatchVC
    }
    
    func execute(userId: String, dogId: String, token: String, otherDogId: String, like: Bool, onSuccess: @escaping (LikeDecodable) -> Void, onError: errorClosure) {
        
        let request: URLRequest = MatchDogsLikeRequest(userId: userId, dogId: dogId, token: token, otherDogId: otherDogId, like: like)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    OperationQueue.main.addOperation{
                        if error == nil {
                            
                            do {
                                if let data = data {
                                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                                    
                                    print(json ?? "Nothing")
                                    
                                    let likes = try JSONDecoder().decode(LikeDecodable.self, from: data)
                                    onSuccess(likes)
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
                else {
                    self.MatchVC.hideActivityIndicator(activityIndicator: self.MatchVC.activityInd)
                    OperationQueue.main.addOperation {
                        self.MatchVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), no hemos podido guardar el like, inténtalo mas tarde")
                    }
                    return
                }
            }
        }
        task.resume()
    }    
}
