//
//  Track.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import ObjectMapper
import Alamofire

class Track: Object {
    
    var trackName = ""
    var trackCollectionName = ""
    var trackImage = ""
    
    override func mapping(map: Map) {
        trackName <- map["trackName"]
        trackCollectionName <- map["collectionName"]
        trackImage <- map["artworkUrl100"]
    }
}

extension Track {
    enum Router: Requestable {
        
        case search(with: String)
        
        var method: Alamofire.HTTPMethod {
            return .get
        }
        
        var path: String {
            return "search"
        }
        
        var parameters: Parameters? {
            switch self {
            case .search(let searchKey): return ["term": searchKey, "media": "music"]
            }
        }
    }
}
