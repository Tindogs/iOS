//
//  ShowMatchesInteractorImpl.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 24/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

class ShowMatchesInteractorImpl: ShowMatchesInteractor {
    
    let dogQueryPreferencesVC: DogQueryPreferencesViewController
    
    init(dogQueryPreferencesVC: DogQueryPreferencesViewController){
        self.dogQueryPreferencesVC = dogQueryPreferencesVC
    }
    
    func execute(userId: String, dogId: String, token: String, onSuccess: @escaping (MatchesDecodable) -> Void, onError: errorClosure) {
        
        let request: URLRequest = ShowMatchesRequest(userId: userId, dogId: dogId, token: token)
        
        let task = URLSession.shared.dataTask(with: request) {(data: Data?,response: URLResponse?,error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    OperationQueue.main.addOperation{
                        if error == nil {
                            
                            do {
                                if let data = data {
                                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                                    
                                    print(json ?? "Nothing")
                                    let matches = try JSONDecoder().decode(MatchesDecodable.self, from: data)
                                    onSuccess(matches)
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
                    self.dogQueryPreferencesVC.hideActivityIndicator(activityIndicator: self.dogQueryPreferencesVC.activityInd)
                    OperationQueue.main.addOperation {
                        self.dogQueryPreferencesVC.showAlert(message: "Ups, tenemos un error \(httpResponse.statusCode), no hemos podido recargar tu lista de matches, lo volveremos intentar más adelante.")
                    }
                    return
                }
            }
        }
        task.resume()
    }
}
