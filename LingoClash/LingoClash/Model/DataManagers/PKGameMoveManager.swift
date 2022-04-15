//
//  PKGameMoveManager.swift
//  LingoClash
//
//  Created by Sherwin Poh on 13/4/22.
//

import PromiseKit

class PKGameManager: DataManager<PKGameMoveData> {
    
    init() {
        super.init(resource: "PKGame")
    }
    
    func createPKGame(pkGameData: PKGameData) -> Promise<PKGame> {
        return firstly {
            create(newRecord: pkGameData)
        }.then { [self] pkGameData -> Promise<PKGame> in
            self.getPKGame(id: pkGameData.id)
        }
    }
    
    func getPKGame(id: Identifier) -> Promise<PKGame> {
        let profileManager = ProfileManager()
        // TODO: Make this more query efficient (in one instead of many)
        return firstly {
            getOne(id: id)
        }.then { pkGameData -> Promise<PKGame> in
            var playerProfilesPromises: [Promise<Profile>] = []
            for playerProfileData in pkGameData.players {
                let playerProfilePromise = profileManager.getProfile(id: playerProfileData.id)
                playerProfilesPromises.append(playerProfilePromise)
            }
            return when(fulfilled: playerProfilesPromises).map { playerProfiles -> PKGame in
                PKGame(id: pkGameData.id, players: playerProfiles, questions: pkGameData.questions)
            }
        }
    }
}
