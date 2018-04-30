//
//  MatchedDetailInteractorImpl.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 27/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

class MatchedDetailInteractorImpl: MatchedDetailInteractor {
    
    let showMatchesVC: ShowMatchesViewController
    
    init(showMatchesVC: ShowMatchesViewController){
        self.showMatchesVC = showMatchesVC
    }
    
    func execute(userId: String, dogId: String, token: String, onSuccess: @escaping (DogDecodable) -> Void, onError: errorClosure) {
        
        let request: URLRequest = LikeDogRequest(userId: userId, dogId: dogId, token: token)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
            OperationQueue.main.addOperation{
                if error == nil {
                    
                    do {
                        if let data = data {
                            let json = try? JSONSerialization.jsonObject(with: data, options: [])
                            
                             print(json ?? "Nothing")
                            let dogs = try JSONDecoder().decode(DogDecodable.self, from: data)
                            onSuccess(dogs)
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
                    OperationQueue.main.addOperation {
                        self.showMatchesVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), no hemos podido recuperar tu match, inténtalo de nuevo más tarde")
                    }
                    return
                }
            }
        }
        task.resume()
    }
    
    
}
