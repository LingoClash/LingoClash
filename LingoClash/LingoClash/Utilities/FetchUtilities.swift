//
//  NetworkUtilities.swift
//  LingoClash
//
//  Created by Kyle キラ on 15/3/22.
//

import Foundation
import PromiseKit



class FetchUtilities {
    static func fetchData(with request: URLRequest) -> Promise<FetchResponse> {
        return Promise { seal in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    seal.reject(error)
                } else {
                    seal.fulfill(
                        FetchResponse(
                            data: data ?? Data(),
                            response: response
                        )
                    )
                }
            }
            task.resume()
        }
    }
    
    static func stringify(query: [String: Any]) -> String {
        var res = ""
        for (key, value) in query {
            res += "\(key)=\(value)&"
        }
        
        let queryString = String(res.dropLast())
        return queryString
    }
}
