//
//  URLSession.swift
//  LingoClash
//
//  Created by Kyle キラ on 21/3/22.
//

import Foundation

//https://developer.apple.com/forums/thread/114119
extension URLSession {

    typealias DataTaskResult = Result<(HTTPURLResponse, Data), Error>

    func dataTask(with request: URLRequest, completionHandler: @escaping (DataTaskResult) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(Result.failure(HTTPError.transportError(error)))
                return
            }
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completionHandler(Result.failure(HTTPError.serverSideError(status)))
                return
            }
            completionHandler(Result.success((response, data!)))
        }
    }
}
