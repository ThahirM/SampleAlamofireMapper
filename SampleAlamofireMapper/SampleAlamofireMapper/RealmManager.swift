//
//  RealmManager.swift
//  SampleAlamofireMapper
//
//  Created by Jafar Khan on 7/19/18.
//  Copyright © 2018 Thahir. All rights reserved.
//

import Realm
import RealmSwift

class RealmManager {
    
    /// Shared Realm Manager
    static let shared = RealmManager()
    private init() {}
    
    let realm = try? Realm()
    
    /// Fetch objects of a specific type from realm
    func fetch<Object: MappableRealmObject>(type: Object.Type) -> [Object] {
        return realm?.objects(type).toArray(type) ?? []
    }
    
    /// Add an object to realm
    func add(object: MappableRealmObject, update: Bool = true) {
        do {
            try realm?.write {
                realm?.add(object, update: update)
            }
        }
        catch {
            print("Failed to add \(object) due to \(error)")
        }
    }
    
    /// Add an array of objects to realm
    func add(objects: [MappableRealmObject], update: Bool = true) {
        do {
            try realm?.write {
                realm?.add(objects, update: update)
            }
        }
        catch {
            print("Failed to add \(objects) due to \(error)")
        }
    }
    
    /// Delete an object from realm
    func delete(object: MappableRealmObject) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        }
        catch {
            print("Failed to delete \(object) due to \(error)")
        }
    }
    
    /// Delete an array of objects from realm
    func delete(objects: [MappableRealmObject]) {
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        }
        catch {
            print("Failed to delete \(objects) due to \(error)")
        }
    }
    
    /// Clear the realm database
    func clearDataBase() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        }
        catch {
            print("Failed to clear DataBase due to \(error)")
        }
    }
}

extension Results {
    
    /// Convert results into array
    func toArray<Object: MappableRealmObject>(_ type: Object.Type) -> [Object] {
        return compactMap { $0 as? Object }
    }
}
