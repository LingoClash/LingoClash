//
//  ProfileViewModel.swift
//  LingoClash
//
//  Created by Kyle キラ on 14/3/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import PromiseKit

final class ProfileViewModel {
    
    @Published var error: String?
    
    private let authProvider: AuthProvider
    
    init(authProvider: AuthProvider = FakeAuthProvider()) {
        self.authProvider = authProvider
    }
    
    func signOut() {
        firstly {
            authProvider.logout()
        }.done {
            self.error = nil
        }.catch { error in
            self.error = error.localizedDescription
        }
    }
    
}
