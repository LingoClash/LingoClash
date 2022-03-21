//
//  LoginViewModel.swift
//  LingoClash
//
//  Created by Kyle キラ on 14/3/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import PromiseKit

final class LoginViewModel {
    
    @Published var error: String?
    
    private let authProvider: AuthProvider
    
    init(authProvider: AuthProvider = FakeAuthProvider()) {
        self.authProvider = authProvider
    }
    
    func login(email: String, password: String) {
        
        let fields = [
            "email": email,
            "password": password
        ]
        
        // Validate fields
        let error = validateFields(fields)
        if let error = error {
            self.error = error
            return
        }
        
        // Sign in
        // TODO:
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
//            self?.error = (error != nil)
//            ? "Incorrect email or password."
//            : nil
//        }
        firstly {
            authProvider.login(params: fields)
        }.catch { error in
            self.error = error.localizedDescription
        }
    }
    
    ///  Returns: nil if fields are correct, else return error message
    func validateFields(_ fields: [String:String]) -> String? {
        // Check that all fields are filled in
        if fields.values.contains("") {
            return "Please fill in all fields."
        }
        
        return nil
    }
    
}
