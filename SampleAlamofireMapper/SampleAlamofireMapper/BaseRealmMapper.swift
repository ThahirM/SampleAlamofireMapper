//
//  BaseRealmMapper.swift
//  SampleAlamofireMapper
//
//  Created by Jafar Khan on 7/23/18.
//  Copyright © 2018 Thahir. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm

class BaseRealmMapper: Object, Mappable {
    required init?(map: Map) {
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    func mapping(map: Map) { }
}
