//
//  FirebaseRestDataProvider.swift
//  LingoClash
//
//  Created by kevin chua on 18/3/22.
//

import Foundation
import PromiseKit

class FirebaseRestDataProvider: JSONServerDataProvider {
    init() {
        super.init(apiURL: "https://firestore.googleapis.com/v1/projects/lingoclash/databases/(default)/documents") { request in
            
            return Promise { seal in
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        seal.fulfill(
                            FetchResult(
                                data: data ?? Data(),
                                response: response
                            )
                        )
                    }
                }
                task.resume()
            }
        }
    }
    
}
