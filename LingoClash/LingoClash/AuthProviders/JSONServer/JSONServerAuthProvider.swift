//
//  JSONServerAuthProvider.swift
//  LingoClash
//
//  Created by Kyle キラ on 21/3/22.
//

import Foundation
import PromiseKit


class JSONServerAuthProvider: AuthProvider {
    
    struct Configs {
        static let emailKey = "email"
        static let passwordKey = "password"
        static let accessTokenKey = "access_token"
    }
    
    private let apiURL: String
    
    init(apiURL: String) {
        self.apiURL = apiURL
    }
    
    func register(params: [String : Any]) -> Promise<Void> {
        guard let email = params[Configs.emailKey] as? String, let password = params[Configs.passwordKey] as? String else {
            return Promise.reject(reason: AuthError.invalidLoginParams)
        }
        
        let userCredentials = UserCredentials(email: email, password: password)
        
        guard let url = URL(string: "\(self.apiURL)/auth/register") else {
            return Promise.reject(
                reason: NetworkError.invalidURL)
        }
        
        guard let data = try? JSONEncoder().encode(userCredentials) else {
            return Promise.reject(reason: NetworkError.invalidParams)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        return FetchUtilities.fetchData(with: request).done { result in
            guard let auth = try? JSONDecoder().decode(LoginResult.self, from: result.data) else {
                return
            }
            
            let accessToken = auth.access_token
            
            try KeychainManager.save(service: self.apiURL, account: Configs.accessTokenKey, value: accessToken.data(using: .utf8) ?? Data())
        }
    }
    
    func login(params: [String: Any]) -> Promise<Void> {
        guard let email = params[Configs.emailKey] as? String, let password = params[Configs.passwordKey] as? String else {
            return Promise.reject(reason: AuthError.invalidLoginParams)
        }
        
        let userCredentials = UserCredentials(email: email, password: password)
        
        guard let url = URL(string: "\(self.apiURL)/auth/login") else {
            return Promise.reject(
                reason: NetworkError.invalidURL)
        }
        
        guard let data = try? JSONEncoder().encode(userCredentials) else {
            return Promise.reject(reason: NetworkError.invalidParams)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        return FetchUtilities.fetchData(with: request).done { result in
            guard let auth = try? JSONDecoder().decode(LoginResult.self, from: result.data) else {
                return
            }
            
            let accessToken = auth.access_token
            
            try KeychainManager.save(service: self.apiURL, account: Configs.accessTokenKey, value: accessToken.data(using: .utf8) ?? Data())
        }
    }
    
    func logout() -> Promise<Void> {
        
        do {
            try KeychainManager.delete(service: self.apiURL, account: Configs.accessTokenKey)
        } catch {
            return Promise.reject(reason: error)
        }
        
        return Promise<Void>.resolve(value: ())
    }
    
    func checkError(error: HTTPError) -> Promise<Void> {
        switch error {
        case .serverSideError(401), .serverSideError(403):
            do {
                try KeychainManager.delete(service: self.apiURL, account: Configs.accessTokenKey)
            } catch {
                return Promise.reject(reason: error)
            }
            return Promise.reject(reason: error)
        default:
            return Promise<Void>.resolve(value: ())
        }
    }
    
    func getIdentity() -> Promise<UserIdentity> {
        guard let url = URL(string: "\(apiURL)/user/me") else {
            return Promise.reject(reason: NetworkError.invalidURL)
        }
        let request = URLRequest(url: url)
        
        return FetchUtilities.fetchData(with: request).compactMap { fetchResult in
            try? JSONDecoder().decode(UserIdentity.self, from: fetchResult.data)
        }
    }
}
