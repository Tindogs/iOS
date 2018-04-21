//
//import Foundation
//
//class UserProfileInteractorFakeImpl: UserProfileInteractor {
//   
//    func getUser(_id: String, token: String, onSuccess: @escaping (User) -> Void, onError: errorClosure) {
//        
//        let dog0 = Dog(_id: "5ad21fcd4058bd4d2f3307db", name: "Churri", age: 5, breed: "Chuchu callejerus", pureBreed: false, color: "Dark Brown", query: nil, likesFromOthers: [], description: "a nice little dog", photos: [])
//        
//        let dog1 = Dog(_id: "5ad224fb4058bd4d2f3307dc", name: "Churri2", age: 1, breed: "Chuchu callejerus", pureBreed: false, color: "white with black dots", query: nil, likesFromOthers: [], description: "a nice puppy", photos: [])
//        
//        let dog2 = Dog(_id: "5ad21fcd4058bd4d2f3307db", name: "Churri3", age: 5, breed: "Chuchu callejerus", pureBreed: false, color: "Dark Brown", query: nil, likesFromOthers: [], description: "a nice little dog", photos: [])
//        
//        let dog3 = Dog(_id: "5ad224fb4058bd4d2f3307dc", name: "Churri4", age: 1, breed: "Chuchu callejerus", pureBreed: false, color: "white with black dots", query: nil, likesFromOthers: [], description: "a nice puppy", photos: [])
//        
//        let dog4 = Dog(_id: "5ad21fcd4058bd4d2f3307db", name: "Churri5", age: 5, breed: "Chuchu callejerus", pureBreed: false, color: "Dark Brown", query: nil, likesFromOthers: [], description: "a nice little dog", photos: [])
//        
//        let dog5 = Dog(_id: "5ad224fb4058bd4d2f3307dc", name: "Churri6", age: 1, breed: "Chuchu callejerus", pureBreed: false, color: "white with black dots", query: nil, likesFromOthers: [], description: "a nice puppy", photos: [])
//        
//        // SIN IMAGEN DE PERFIL
//        //        let user = User(_id: "5ad115514058bd4d2f330769", firstName: "Fabio", lastName: "Gómez", email: "gomez.fabio@gmail.com", userName: "Fabio", password: "9c2e4d8fe97d881430de4e754b4205b9c27ce96715231cffc4337340cb110280", coordinates: [], photo: nil, dogs: [dog0,dog1,dog2,dog3,dog4,dog5])
//        
//        // FULL EQUIP
//        let user = User(_id: "5ad115514058bd4d2f330769", firstName: "Fabio", lastName: "Gómez", email: "gomez.fabio@gmail.com", userName: "Fabio", password: "9c2e4d8fe97d881430de4e754b4205b9c27ce96715231cffc4337340cb110280", coordinates: [], photo: "https://firebasestorage.googleapis.com/v0/b/test-26620.appspot.com/o/images%2FCDE8BB19-196C-4F56-A8C7-EDFE8060CB6C.jpg?alt=media&token=57803180-bcae-466c-9549-36da792c652f", dogs: [dog0,dog1,dog2,dog3,dog4,dog5])
//        
//        // SIN PERRETES EN EL ARRAY DE dogs
//        //        let user = User(_id: "5ad115514058bd4d2f330769", firstName: "Fabio", lastName: "Gómez", email: "gomez.fabio@gmail.com", userName: "Fabio", password: "9c2e4d8fe97d881430de4e754b4205b9c27ce96715231cffc4337340cb110280", coordinates: [], photo: "https://firebasestorage.googleapis.com/v0/b/test-26620.appspot.com/o/images%2FCDE8BB19-196C-4F56-A8C7-EDFE8060CB6C.jpg?alt=media&token=57803180-bcae-466c-9549-36da792c652f", dogs: [])
//        
//        OperationQueue.main.addOperation {
//            onSuccess(user)
//        }
//    }    
//}
//
