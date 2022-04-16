//
//  ProfileDataManager.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 23/3/22.
//

import PromiseKit
import Foundation

class ProfileManager: DataManager<ProfileData> {

    private var authProvider: AuthProvider

    init(authProvider: AuthProvider = FirebaseAuthProvider()) {
        self.authProvider = authProvider

        super.init(resource: DataManagerResources.profiles)
    }

    func getCurrentProfileData() -> Promise<ProfileData> {
        firstly {
            authProvider.getIdentity()
        }.then { userIdentity in
            self.getManyReference(target: "user_id", id: userIdentity.id ?? "-1")
        }.compactMap { profilesData in
            guard !profilesData.isEmpty else {
                return nil
            }

            return profilesData[0]
        }
    }

    func getCurrentProfile() -> Promise<Profile> {
        let currentProfileData = self.getCurrentProfileData()
        return buildNestedProfile(profileData: currentProfileData)
    }

    func getProfile(id: Identifier) -> Promise<Profile> {
        let profileData = self.getOne(id: id)
        return buildNestedProfile(profileData: profileData)
    }

    func setAsCurrentBook(bookId: Identifier) -> Promise<ProfileData> {

        firstly {
            self.getCurrentProfileData()
        }.then { profileData -> Promise<ProfileData> in
            let newProfileData = ProfileData(
                id: profileData.id,
                book_id: bookId,
                user_id: profileData.user_id,
                name: profileData.name,
                email: profileData.email,
                stars: profileData.stars,
                stars_today: profileData.stars_today,
                stars_goal: profileData.stars_goal,
                bio: profileData.bio,
                days_learning: profileData.days_learning,
                vocabs_learnt: profileData.vocabs_learnt
            )

            return self.update(id: profileData.id, from: profileData, to: newProfileData)
        }
    }

    func updateProfile(starsGoal: Int, bio: String) -> Promise<ProfileData> {

        firstly {
            self.getCurrentProfileData()
        }.then { profileData -> Promise<ProfileData> in
            let newProfileData = ProfileData(
                id: profileData.id,
                book_id: profileData.book_id,
                user_id: profileData.user_id,
                name: profileData.name,
                email: profileData.email,
                stars: profileData.stars,
                stars_today: profileData.stars_today,
                stars_goal: starsGoal,
                bio: bio,
                days_learning: profileData.days_learning,
                vocabs_learnt: profileData.vocabs_learnt
            )

            return self.update(id: profileData.id, from: profileData, to: newProfileData)
        }
    }

    private func buildNestedProfile(
        profileData: Promise<ProfileData>) -> Promise<Profile> {
        var profile: ProfileData?
        var currentBook: Book?
        var rankingByTotalStars: Int?
        var winningPKRate: Double?

        return profileData.then { profileData-> Promise<Void> in
            // Gets the current book
            profile = profileData
            guard let currentBookId = profileData.book_id else {
                return Promise<Void>.resolve(value: ())
            }

            return firstly {
                BookManager().getBook(id: currentBookId)
            }.done { book in
                currentBook = book
            }
        }.then { () -> Promise<Void> in
            // Gets the ranking of the profile by total stars
            guard let profile = profile else {
                return Promise.reject(reason: DataManagerError.dataNotFound)
            }

            return firstly {
                self.getList()
            }.done { profiles in
                let sortedProfiles = profiles.sorted(by: { (p1: ProfileData, p2: ProfileData) -> Bool in
                    p1.stars < p2.stars
                })

                rankingByTotalStars = sortedProfiles.firstIndex {
                    $0.id == profile.id
                }

                rankingByTotalStars? += 1

            }
        }.then { () -> Promise<Void> in
            // Gets the pk winning rate
            guard let profile = profile else {
                return Promise.reject(reason: DataManagerError.dataNotFound)
            }

            return firstly { () -> Promise<[PKGamePlayerOutcomeData]> in
                // 1. get the list of player outcomes whose profile_id = profile.id
                let filters: [String: Any] = [
                    "profile_id": profile.id
                ]
                return PKGamePlayerOutcomeManager().getList(filter: filters)
            }.done { playerOutcomes in
                var uniquePlayerOutcomes = Set<PKGamePlayerOutcomeData>()
                for outcome in playerOutcomes {
                    uniquePlayerOutcomes.insert(outcome)
                }

                let wins = uniquePlayerOutcomes.filter { $0.outcome == .win }.count
                let total = uniquePlayerOutcomes.count
                winningPKRate = Double(wins) / Double(total) * 100
            }
        }.compactMap {
            guard let profile = profile,
                    let rankingByTotalStars = rankingByTotalStars,
                    let winningPKRate = winningPKRate else {
                return nil
            }

            return Profile(
                profileData: profile,
                currentBook: currentBook,
                rankingByTotalStars: rankingByTotalStars, pkWinningRate: winningPKRate)
        }
    }
}
