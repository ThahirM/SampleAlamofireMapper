//
//  BaseMappable.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import ObjectMapper
import ObjectMapper_Realm
import Realm
import RealmSwift

class MappableObject: Mappable {
    required init?(map: Map) {}
    func mapping(map: Map) {}
}

protocol Caching {}

class MappableRealmObject: Object, Mappable, Caching {
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {}
}

extension Caching where Self: MappableRealmObject {
    
    /// Fetch all cached objects of this type
    static func cached() -> [Self] {
        return RealmManager.shared.fetch(type: self)
    }
    
    /// Add this object to realm
    func add(update: Bool = true) {
        RealmManager.shared.add(object: self, update: update)
    }
    
    /// Delete this object from realm
    func delete() {
        RealmManager.shared.delete(object: self)
    }
    
    /// Update the object inside update handler
    func update(updateHandler: (Self) -> Void) {
        try? RealmManager.shared.realm?.write {
            updateHandler(self)
        }
    }
}

extension Array: Caching where Element: MappableRealmObject {
    
    /// Add objects to realm
    func addToRealm(update: Bool = true) {
        RealmManager.shared.add(objects: self, update: true)
    }
    
    /// Delete objects from realm
    func deleteFromRealm() {
        RealmManager.shared.delete(objects: self)
    }
}
