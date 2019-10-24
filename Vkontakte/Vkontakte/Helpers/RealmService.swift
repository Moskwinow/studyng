//
//  RealmService.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 9/1/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import Foundation
import RealmSwift


class RealmService {
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(items: [T], configuration: Realm.Configuration = deleteIfMigration, update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.add(items, update: update)
            print(configuration.fileURL)
        }
    }
    
    static func get<T: Object>(_ type: T.Type, configuration: Realm.Configuration = deleteIfMigration) throws -> Results<T> {
        let realm = try Realm(configuration: configuration)
        
        return realm.objects(type)
    }
}
