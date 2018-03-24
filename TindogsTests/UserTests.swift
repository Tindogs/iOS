import XCTest
@testable import Tindogs

class UserTests: XCTestCase {
    
    var dog1 : Dog!
    
    override func setUp() {
        super.setUp()
        
        dog1 = Dog(_id: "5aa9b60ccc9b4e411d36abac", name: "haptic")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserExistence() {
    
        let user1 = User(_id: "5aa9b60ccc9b4e411d36abad", firstName: "Mario", lastName: "Velásquez", email: "Sergio80@hotmail.com", userName: "Lucas.Vera21")
        let user2 = User(_id: "5aa9b60ccc9b4e411d36abad", firstName: "Mario", lastName: "Velásquez", email: "Sergio80@hotmail.com", userName: "Lucas.Vera21", coordinates: [37.80074961014888,-3.9022045745662908], photo:"http://lorempixel.com/640/480/animals", dogs: [dog1])
        
        
        XCTAssertNotNil(user1)
        XCTAssertNotNil(user2)
    }
    
}
