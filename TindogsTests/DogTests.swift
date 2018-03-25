import XCTest
@testable import Tindogs

class DogTests: XCTestCase {
    
    var query: Query!
    var likesFromOthers: LikesFromOthers!
    
    override func setUp() {
        super.setUp()
        
        query = Query(ageFrom: 3, ageTo: 8, maxKms: 50.0, reproductive: true, breed: "Husky")
        likesFromOthers = LikesFromOthers(dogLikeId: "5aa9b60ccc9b4e411d36a97a", dogName: "solid state", ownerId: "5aa9b60ccc9b4e411d36a97b", ownerName: "Gerardo")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDogExistence() {
    
        let dog1 = Dog(_id: "5aa9b60ccc9b4e411d36abac", name: "haptic")
        let dog2 = Dog(_id: "5aa9b60ccc9b4e411d36abac", name: "haptic", age: 3, breed: "Husky", pureBreed: true, color: "Negro y blanco", query: query, likesFromOthers: [likesFromOthers], description: "Perrete muy guapo y obediente", photos: ["http://lorempixel.com/640/480/animals","http://lorempixel.com/640/480/animals"])
        
        XCTAssertNotNil(dog1)
        XCTAssertNotNil(dog2)
    }
    
}

