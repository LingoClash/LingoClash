//
//  FirebaseAuthProvider.swift
//  LingoClash
//
//  Created by Kyle キラ on 21/3/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import PromiseKit



enum FirebaseAuthError: Error {
    case invalidAuthParams
    case invalidAuthDataResult
}

class FirebaseAuthProvider: AuthProvider {
    
    struct Configs {
        static let emailKey = "email"
        static let passwordKey = "password"
        static let firstNameKey = "firstName"
        static let lastNameKey = "lastName"
    }
    
    func register(params: [String : Any]) -> Promise<Void> {
        
        guard let email = params[Configs.emailKey] as? String,
              let password = params[Configs.passwordKey] as? String,
                let firstName = params[Configs.firstNameKey] as? String,
                let lastName = params[Configs.lastNameKey] as? String
        else {
            return Promise.reject(reason: FirebaseAuthError.invalidAuthParams)
        }
        
        return Promise<AuthDataResult?> { seal in
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    return seal.reject(error)
                }
                
                return seal.fulfill(result)
            }
        }.then { result -> Promise<Void> in
            guard let result = result else {
                return Promise.reject(reason: FirebaseAuthError.invalidAuthDataResult)
            }
            
            return Promise { seal in
                let db = Firestore.firestore()
                db.collection("users").addDocument(
                    data: [
                        "firstName":firstName,
                        "lastName":lastName,
                        "uid":result.user.uid
                    ]) { error in
                    
                    if let error = error {
                        return seal.reject(error)
                    }
                    return seal.fulfill(())
                }
            }
        }
    }
    
    func login(params: [String : Any]) -> Promise<Void> {
        <#code#>
    }
    
    func logout() -> Promise<Void> {
        <#code#>
    }
    
    func checkError(error: HTTPError) -> Promise<Void> {
        <#code#>
    }
    
    func getIdentity() -> Promise<UserIdentity> {
        <#code#>
    }
    
}
