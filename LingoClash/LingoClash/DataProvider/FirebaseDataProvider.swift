//
//  FirebaseDataProvider.swift
//  LingoClash
//
//  Created by kevin chua on 19/3/22.
//

import Foundation
import Firebase
import PromiseKit

// Uses completion handlers instead of Promises
class FirebaseDataProvider {
    
    typealias HttpClient = (_ request: URLRequest) -> Promise<FetchResult>
    
    private var db = Firestore.firestore()
    private var ref = Database.database().reference()
    
    init() {}
    
    func getList(resource: String, params: GetListParams,
                 completion: @escaping ([Book], Error?) -> Void) {
        db.collection(resource).getDocuments() { (querySnapshot, err) in
            var books: [Book] = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let bookInfo = document.data() as [String: Any]
                    let category = bookInfo["books_category_id"] as? Identifier
                    let name = bookInfo["name"] as? String
                    
                    books.append(Book(books_category_id: category ?? "", name: name ?? ""))
                }
                completion(books, err)
            }
        }
    }
    
    func getOne(resource: String, params: GetOneParams,
                completion: @escaping (Book, Error?) -> Void) {
        db.collection(resource).document(params.id).getDocument() { (document, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let document = document, document.exists else {
                    return
                }
                
                let bookInfo = document.data()
                let category = bookInfo?["books_category_id"] as? Identifier
                let name = bookInfo?["name"] as? String
                
                completion(Book(books_category_id: category ?? "", name: name ?? ""), err)
            }
        }
    }

    func getMany(resource: String, params: GetManyParams,
                 completion: @escaping ([Book], Error?) -> Void) {
        db.collection(resource).getDocuments() { (querySnapshot, err) in
           var books: [Book] = []
           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               for document in querySnapshot!.documents {
                   let bookInfo = document.data() as? [String: Any]
                   let category = bookInfo?["books_category_id"] as? Identifier
                   let name = bookInfo?["name"] as? String
                   let id = bookInfo?["id"] as? String
                   
                   if params.ids.contains(id ?? "") {
                       books.append(Book(books_category_id: category ?? "", name: name ?? ""))
                   }
               }
               completion(books, err)
           }
        }
    }
//
//    func getManyReference(resource: String, params: GetManyReferenceParams) -> Promise<GetManyReferenceResult> {
//        let pagination = params.pagination
//        let sort = params.sort
//        let _query = [
//            params.target: params.id,
//            "_sort": sort.field,
//            "_order": sort.order,
//            "_start": (pagination.page - 1) * pagination.perPage,
//            "_end": pagination.page * pagination.perPage
//        ] as [String : Any]
//        let query = _query.merging(params.filter) { (current, _) in current }
//
//        guard let url = URL(string: "\(apiURL)/\(resource)?\(FetchUtilities.stringify(query: query))") else {
//            return Promise.reject(reason: NetworkError.invalidURL)
//        }
//        let request = URLRequest(url: url)
//
//        return httpClient(request).compactMap { fetchResult in
//
//            let response = fetchResult.response as? HTTPURLResponse
//            guard let count = Int(response?.allHeaderFields["X-Total-Count"] as? String ?? "") else {
//                return nil
//            }
//
//            return GetManyReferenceResult(data: fetchResult.data, total: count)
//        }
//
//    }
//
//    func update(resource: String, params: UpdateParams) -> Promise<UpdateResult> {
//        guard let url = URL(string: "\(apiURL)/\(resource)/\(params.id)") else {
//            return Promise.reject(reason: NetworkError.invalidURL)
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = params.data
//
//        return httpClient(request).map { fetchResult in
//            UpdateResult(data: fetchResult.data)
//        }
//    }
//
//    // json-server doesn't handle filters on UPDATE route, so we fallback to calling UPDATE n times instead
//    func updateMany(resource: String, params: UpdateManyParams) -> Promise<UpdateManyResult> {
//
//        firstly { () -> Promise<[FetchResult]> in
//            let promises = params.ids.map { id -> Promise<FetchResult> in
//                guard let url = URL(string: "\(apiURL)/\(resource)/\(id)") else {
//                    return Promise.reject(reason: NetworkError.invalidURL)
//                }
//
//                var request = URLRequest(url: url)
//                request.httpMethod = "PUT"
//                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//                request.httpBody = params.data
//
//                return httpClient(request)
//            }
//
//            return when(fulfilled: promises)
//        }.map { results in
//            UpdateManyResult(data: results.compactMap {
//                let record = try? JSONDecoder().decode(
//                    Record.self, from: $0.data)
//
//                return record?.id
//            })
//        }
//
//    }
//
//    func create(resource: String, params: CreateParams) -> Promise<CreateResult> {
//
//        guard let url = URL(string: "\(apiURL)/\(resource)") else {
//            return Promise.reject(
//                reason: NetworkError.invalidURL)
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = params.data
//
//        return httpClient(request).map { fetchResult in
//            CreateResult(data: fetchResult.data)
//        }
//    }
//
//    func delete(resource: String, params: DeleteParams) -> Promise<DeleteResult> {
//        guard let url = URL(string: "\(apiURL)/\(resource)/\(params.id)") else {
//            return Promise.reject(reason: NetworkError.invalidURL)
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//
//        return httpClient(request).map { fetchResult in
//            DeleteResult(data: fetchResult.data)
//        }
//    }
//
//    // json-server doesn't handle filters on DELETE route, so we fallback to calling DELETE n times instead
//    func deleteMany(resource: String, params: DeleteManyParams) -> Promise<DeleteManyResult> {
//
//        firstly { () -> Promise<[FetchResult]> in
//            let promises = params.ids.map { id -> Promise<FetchResult> in
//                guard let url = URL(string: "\(apiURL)/\(resource)/\(id)") else {
//                    return Promise.reject(reason: NetworkError.invalidURL)
//                }
//
//                var request = URLRequest(url: url)
//                request.httpMethod = "DELETE"
//
//                return httpClient(request)
//            }
//
//            return when(fulfilled: promises)
//        }.map { results in
//            DeleteManyResult(data: results.compactMap {
//                let record = try? JSONDecoder().decode(
//                    Record.self, from: $0.data)
//
//                return record?.id
//            })
//        }
//
//    }
    
}
