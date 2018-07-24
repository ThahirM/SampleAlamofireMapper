//
//  OffRoadingTip.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 7/24/18.
//  Copyright © 2018 Thahir. All rights reserved.
//

import ObjectMapper
import Alamofire
import PromiseKit
import RealmSwift
import ObjectMapper_Realm

class LocalizedObject: MappableRealmObject {
    dynamic var id = ""
    dynamic var english = ""
    dynamic var arabic = ""
    dynamic var french = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // the localized country name
    var localized: String {
        return english
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["en"]
        english <- map["en"]
        arabic <- map["ar"]
        french <- map["fr"]
    }
}

class OffroadingTip: MappableRealmObject {
    
    dynamic var id = 0
    var guides = List<Guide>()
    dynamic var name: LocalizedObject?
    dynamic var backgroundImage = ""
    dynamic var iconImage = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override func mapping(map: Map) {
        id                   <- map["id"]
        guides               <- (map["guides"], ListTransform<Guide>())
        name                 <- map["name"]
        backgroundImage      <- map["images.background"]
        iconImage            <- map["images.icon"]
    }
}

class Guide: MappableRealmObject {
    
    dynamic var id = 0
    dynamic var name: LocalizedObject?
    dynamic var guideDescription: LocalizedObject?
    dynamic var backgroundImage = ""
    dynamic var foregroundImage = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override func mapping(map: Map) {
        id                   <- map["id"]
        name                 <- map["name"]
        guideDescription     <- map["description"]
        backgroundImage      <- map["images.background"]
        foregroundImage      <- map["images.foreground"]
    }
}

extension OffroadingTip {
    enum Router: Requestable {
        
        case fetch
        
        var method: Alamofire.HTTPMethod {
            return .get
        }
        
        var path: String {
            return "guides"
        }
        
        var parameters: Parameters? {
            return ["locale": "en", "api_key": "fbe941dc3964ef44b24514e5e5df0eda7653cddf"]
        }
    }
}

extension OffroadingTip {
    class FetchResponse: MappableObject {
        var offroadingTips = [OffroadingTip]()
        var imagesZip = ""
        
        override func mapping(map: Map) {
            offroadingTips  <- map["categories"]
            imagesZip       <- map["images_zip"]
        }
    }
}


extension OffroadingTip {
    static func fetchOffroadingTips() -> Promise<FetchResponse> {
        return Promise { (fulfil, reject) in
            Router.fetch.request { (response: DataResponse<FetchResponse>) in
                
                // handle errors if any
                guard response.error == nil else {
                    reject(response.error!)
                    return
                }
                
                // abort if we got unexpected result
                guard let value = response.value else {
                    let error = NSError(domain: "JSONResponseError", code: 3841, userInfo: nil)
                    reject(error)
                    return
                }
                
                // save tracks
                value.offroadingTips.addToRealm()
                
                fulfil(value)
            }
        }
    }
}
