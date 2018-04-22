//
//  MatchDogsInteractorFakeImpl.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

class MatchDogsInteractorFakeImpl: MatchDogsInteractor {
    func execute(userId: String, dogId: String, token: String, onSuccess: @escaping (DogDecodable) -> Void, onError: errorClosure) {
        
//        let dogs: [DogDecodable] = getDogArray()
        
        OperationQueue.main.addOperation {
            onSuccess(DogDecodable(result: [DogDecodable.DogResponse(_id: "", name: "", age: 0, purebreed: false, likes_from_others: [], description: "", photos: [])], succes: true))
        }
    }
    
//    func getDogArray() -> [DogDecodable] {
//        let dog1 = DogDecodable(_id: "5acba449aa64ce3986f0948f",
//            name: "dog" ,
//            age: 12,
//            breed: "breed1", pureBreed: true, color: "color1", query: nil, likesFromOthers: nil, description: "description1", photos: ["https://vetstreet.brightspotcdn.com/dims4/default/5b3ffe7/2147483647/thumbnail/180x180/quality/90/?url=https%3A%2F%2Fvetstreet-brightspot.s3.amazonaws.com%2F8e%2F4e3910c36111e0bfca0050568d6ceb%2Ffile%2Fhub-dogs-puppy.jpg"])
//
//        let dog2 = DogDecodable(_id: "5acba449aa64ce3986f0948f",
//                       name: "dog" ,
//                       age: 12,
//                       breed: "breed1", pureBreed: true, color: "color1", query: nil, likesFromOthers: nil, description: "description1", photos: ["https://static.scientificamerican.com/blogs/cache/file/47B88223-FAE5-48E5-929BDBBA879BFD60.jpg?w=590&h=393&E40CC489-F6F6-4912-AFB0CF3F4ED32FE6"])
//
//        let dog3 = Dog(_id: "5acba449aa64ce3986f0948f",
//                       name: "dog" ,
//                       age: 12,
//                       breed: "breed1", pureBreed: true, color: "color1", query: nil, likesFromOthers: nil, description: "description1", photos: ["http://www.dnamag.mx/wp-content/uploads/2017/09/Why_all_dogs_love_us_close_up_large.jpg"])
//
//        let dog4 = Dog(_id: "5acba449aa64ce3986f0948f",
//                       name: "dog" ,
//                       age: 12,
//                       breed: "breed1", pureBreed: true, color: "color1", query: nil, likesFromOthers: nil, description: "description1", photos: ["https://static01.nyt.com/images/2018/02/11/realestate/11dogs-topbreeds-Chihuahua/11dogs-topbreeds-Chihuahua-master495.jpg"])
//
//        let dog5 = Dog(_id: "5acba449aa64ce3986f0948f",
//                       name: "dog" ,
//                       age: 12,
//                       breed: "breed1", pureBreed: true, color: "color1", query: nil, likesFromOthers: nil, description: "description1", photos: ["https://static01.nyt.com/images/2018/02/11/realestate/11dogs-topbreeds2/11dogs-topbreeds2-master495.jpg"])
//
//        return [dog1, dog2, dog3, dog4, dog5]
//    }
//
    
}
