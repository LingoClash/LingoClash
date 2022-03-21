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
    
    func refreshProfile() {
        // get user profile
        self.name = "John Doe"
        self.email = "guy@gmail.com"
        self.totalStars = 5
        self.starsToday = 1
    }
}
