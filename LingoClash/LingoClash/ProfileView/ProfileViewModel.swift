//
//  ProfileViewModel.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 21/3/22.
//

import Combine

final class ProfileViewModel {
    
    @Published var name: String?
    @Published var email: String?
    @Published var totalStars: Int?
    @Published var starsToday: Int?
    
    var firstName: String?
    var lastName: String?
    
    func refreshProfile() {
        // TODO: get user profile
        self.firstName = "John"
        self.lastName = "Doe"
        self.name = "John Doe"
        self.email = "guy@gmail.com"
        self.totalStars = 5
        self.starsToday = 1
    }
    
    func editProfile(firstName: String, lastName: String) {
        // TODO: edit profile
    }
    
    func changeEmail(newEmail: String, confirmNewEmail: String) {
        // TODO: change email
    }
    
    func changePassword(currentPassword: String, newPassword: String, confirmNewPassword: String) {
        // TODO: change password
    }
}
