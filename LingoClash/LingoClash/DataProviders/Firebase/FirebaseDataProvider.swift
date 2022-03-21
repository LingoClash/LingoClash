//
//  FirebaseDataProvider.swift
//  LingoClash
//
//  Created by Kyle キラ on 14/3/22.
//

import Foundation
import PromiseKit
import FirebaseFirestore


class FirebaseDataProvider: DataProvider {
    
    enum FirebaseDataProviderError: Error {
        case invalidQuerySnapshot
        case documentNotFound
        case serializationError
    }
    
    private let db = Firestore.firestore()
    
    private func getData(from document: QueryDocumentSnapshot) -> Data? {
        var documentData = document.data()
        documentData["id"] = document.documentID
        
        return try? JSONSerialization.data(withJSONObject: documentData)
    }
    
    private func getData(from document: DocumentSnapshot) -> Data? {
        guard var documentData = document.data() else {
            return nil
        }
        
        documentData["id"] = document.documentID
        
        return try? JSONSerialization.data(withJSONObject: documentData)
    }
    
    func getList(resource: String, params: GetListParams) -> Promise<GetListResult> {
        
        return Promise { seal in
            db.collection(resource).getDocuments { (querySnapshot, error) in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                guard let querySnapshot = querySnapshot else {
                    return seal.reject(FirebaseDataProviderError.invalidQuerySnapshot)
                }
                
                let dataList = querySnapshot.documents.compactMap { document -> Data? in
                    self.getData(from: document)
                }
                
                return seal.fulfill(GetListResult(data: dataList, total: querySnapshot.count))
            }
        }
    }
    
    func getOne(resource: String, params: GetOneParams) -> Promise<GetOneResult> {
        
        return Promise { seal in
            let docRef = db.collection(resource).document(params.id)
            
            docRef.getDocument { (document, error) in
                guard let document = document, document.exists else {
                    return seal.reject(FirebaseDataProviderError.documentNotFound)
                }
                
                guard let data = self.getData(from: document) else {
                    return seal.reject(FirebaseDataProviderError.serializationError)
                }
                
                return seal.fulfill(GetOneResult(data: data))
            }
        }
    }
    
    func getMany(resource: String, params: GetManyParams) -> Promise<GetManyResult> {
                
        return Promise { seal in
            let collection = db.collection(resource)
            
            collection.whereField("uid", in: params.ids).getDocuments { (querySnapshot, error) in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                guard let querySnapshot = querySnapshot else {
                    return seal.reject(FirebaseDataProviderError.invalidQuerySnapshot)
                }
                
                let dataList = querySnapshot.documents.compactMap { document -> Data? in
                    self.getData(from: document)
                }
                
                return seal.fulfill(GetManyResult(data: dataList))
            }
        }
    }
    
    func getManyReference(resource: String, params: GetManyReferenceParams) -> Promise<GetManyReferenceResult> {
        
        return Promise { seal in
            var filteredCollection = db.collection(resource).whereField(params.target, isEqualTo: params.id)
            
            for (key, value) in params.filter {
                filteredCollection = filteredCollection.whereField(key, isEqualTo: value)
            }
            
            filteredCollection.getDocuments { (querySnapshot, error) in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                guard let querySnapshot = querySnapshot else {
                    return seal.reject(FirebaseDataProviderError.invalidQuerySnapshot)
                }
                
                let dataList = querySnapshot.documents.compactMap { document -> Data? in
                    self.getData(from: document)
                }
                
                return seal.fulfill(GetManyReferenceResult(data: dataList, total: querySnapshot.count))
            }
        }
    }
    
    func update(resource: String, params: UpdateParams) -> Promise<UpdateResult> {
        return Promise<UpdateResult>.resolve(value: UpdateResult(data: Data()))
    }
    
    func updateMany(resource: String, params: UpdateManyParams) -> Promise<UpdateManyResult> {
        return Promise<UpdateManyResult>.resolve(value: UpdateManyResult(data: []))
    }
    
    func create(resource: String, params: CreateParams) -> Promise<CreateResult> {
        return Promise<CreateResult>.resolve(value: CreateResult(data: Data()))
    }
    
    func delete(resource: String, params: DeleteParams) -> Promise<DeleteResult> {
        return Promise<DeleteResult>.resolve(value: DeleteResult(data: Data()))
    }
    
    func deleteMany(resource: String, params: DeleteManyParams) -> Promise<DeleteManyResult> {
        return Promise<DeleteManyResult>.resolve(value: DeleteManyResult(data: []))
    }
}
