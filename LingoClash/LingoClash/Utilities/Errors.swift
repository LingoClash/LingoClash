//
//  Error.swift
//  LingoClash
//
//  Created by Kyle キラ on 15/3/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidParams
}

enum HTTPError: Error {
    case transportError(Error)
    case serverSideError(Int)
}

enum DatabaseError: Error {
    case invalidFormat
}

enum AuthError: Error  {
    case invalidLoginParams
    case invalidLogoutParams
}
