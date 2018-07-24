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

protocol RealmCaching {}

class MappableRealmObject: Object, Mappable, RealmCaching {
    
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

extension RealmCaching where Self: MappableRealmObject {
    
    static func cached() -> [Self] {
        return RealmManager.shared.fetch(type: self)
    }
    
    func add(update: Bool = true) {
        RealmManager.shared.add(object: self, update: update)
    }
    
    func delete() {
        RealmManager.shared.delete(object: self)
    }
    
    func update(updateHandler: (Self) -> Void) {
        try? RealmManager.shared.realm?.write {
            updateHandler(self)
        }
    }
}
