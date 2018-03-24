import Foundation 

final class Dog {
    var _id: String
    var name: String
    var age: Int? = nil
    var breed: String? = ""
    var pureBreed: Bool? = nil
    var color: String? = nil
    var query: Query? = nil
    var likesFromOthers: [LikesFromOthers]? = nil
    var description: String? = ""
    var photos: [String]? = nil
    
    init(_id: String, name: String){
        self._id = _id
        self.name = name
    }
    
    init(_id: String, name: String, age: Int?, breed: String?, pureBreed: Bool?, color: String?, query: Query?, likesFromOthers: [LikesFromOthers]?, description: String?, photos: [String]?){
        self._id = _id
        self.name = name
        self.age = age
        self.breed = breed
        self.pureBreed = pureBreed
        self.color = color
        self.query = query
        self.likesFromOthers = likesFromOthers
        self.description = description
        self.photos = photos
    }
}

final class Query {
    let ageFrom: Double
    let ageTo: Double
    let maxKms: Double
    let reproductive: Bool
    let breed: String
    
    init(ageFrom: Double, ageTo: Double, maxKms: Double, reproductive: Bool, breed: String){
        self.ageFrom = ageFrom
        self.ageTo = ageTo
        self.maxKms = maxKms
        self.reproductive = reproductive
        self.breed = breed
    }
}

final class LikesFromOthers {
    let dogLikeId: String
    let dogName: String
    let ownerId: String
    let ownerName: String
    
    init(dogLikeId: String, dogName: String, ownerId: String, ownerName: String){
        self.dogLikeId = dogLikeId
        self.dogName = dogName
        self.ownerId = ownerId
        self.ownerName = ownerName
    }
    
}
