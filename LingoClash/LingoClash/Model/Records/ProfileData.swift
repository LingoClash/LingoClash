//
//  Profile.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 23/3/22.
//

struct ProfileData {
    var id: Identifier
    let book_id: Identifier?
    let user_id: Identifier
    let stars: Int
    let stars_goal: Int
    let bio: String
    let days_learning: Int
    let vocabs_learnt: Int
    let pk_winning_rate: Double
    
    init(id: Identifier, book_id: Identifier?, user_id: Identifier,
         stars: Int, stars_goal: Int, bio: String,
         days_learning: Int, vocabs_learnt: Int, pk_winning_rate: Double) {
        self.id = id
        self.book_id = book_id
        self.user_id = user_id
        self.stars = stars
        self.stars_goal = stars_goal
        self.bio = bio
        self.days_learning = days_learning
        self.vocabs_learnt = vocabs_learnt
        self.pk_winning_rate = pk_winning_rate
    }
    
    /// Creates a new default profile data for a user.
    init(userId: Identifier) {
        self.init(id: "-1", book_id: nil, user_id: userId,
                  stars: 0, stars_goal: 3,
                  bio: "Life is a journey of learning.",
                  days_learning: 0, vocabs_learnt: 0, pk_winning_rate: 0)
    }
}

extension ProfileData: Record {}
