import XCTest
@testable import Tindogs

class UserTests: XCTestCase {
    
    var user1: User!
    var user2: User!
    var dog1: Dog!
    var dog2: Dog!
    
    override func setUp() {
        super.setUp()
        
        dog1 = Dog(name: "haptic")
        dog2 = Dog(name: "multi-byte")

        user1 = User(firstName: "Mario", lastName: "Velásquez", email: "Sergio80@hotmail.com", userName: "Lucas.Vera21", password: "mipass")
        user2 = User(_id: "5aa9b60ccc9b4e411d36ab99", firstName: "Jesús", lastName: "Frías", email: "Laura_Naranjo@hotmail.com", userName: "Horacio82", password:"mipass", coordinates: [37.39954097923211,-0.5426998389300168], photo: "http://lorempixel.com/640/480/animals", dogs: [dog1])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserExistence() {
        
        XCTAssertNotNil(user1)
        XCTAssertNotNil(user2)
    }
    
    func testAddDogToUser() {
        
        XCTAssertEqual(user1.dogs?.count, 0)
        
        user1.addDog(dog: dog2)
        
        XCTAssertEqual(user1.dogs?.count, 1)
        
        
        XCTAssertEqual(user2.dogs?.count, 1)
        
        user2.addDog(dog: dog2)
        
        XCTAssertEqual(user2.dogs?.count, 2)

    }
    
    func testAddCoordinatesToUser() {

        let newCoordinates : [Double] = [39.00776703201089,-3.1326542649830564]
        
        XCTAssertEqual(user1.coordinates?.count, 0)
        
        user1.addCoordinates(coordinates: newCoordinates)
        
        XCTAssertEqual(user1.coordinates?.count, 2)
    }
    
}
