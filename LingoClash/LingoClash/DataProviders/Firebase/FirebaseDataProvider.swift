//
//  FirebaseDataProvider.swift
//  LingoClash
//
//  Created by Kyle キラ on 14/3/22.
//

import Foundation
import PromiseKit


class FirebaseDataProvider: DataProvider {
    func getList(resource: String, params: GetListParams) -> Promise<GetListResult> {
        return Promise<GetListResult>.resolve(value: GetListResult(data: Data(), total: 0))
    }
    
    func getOne(resource: String, params: GetOneParams) -> Promise<GetOneResult> {
        return Promise<GetOneResult>.resolve(value: GetOneResult(data: Data()))
    }
    
    func getMany(resource: String, params: GetManyParams) -> Promise<GetManyResult> {
        return Promise<GetManyResult>.resolve(value: GetManyResult(data: Data()))
    }
    
    func getManyReference(resource: String, params: GetManyReferenceParams) -> Promise<GetManyReferenceResult> {
        return Promise<GetManyReferenceResult>.resolve(value: GetManyReferenceResult(data: Data(), total: 0))
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
