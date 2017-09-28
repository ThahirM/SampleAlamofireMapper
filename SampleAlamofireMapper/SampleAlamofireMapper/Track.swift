//
//  Track.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import ObjectMapper
import Alamofire
import PromiseKit

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

extension Track {
    class SearchResponse: Object {
        
        var count = 0
        var tracks: [Track]?
        
        override func mapping(map: Map) {
            count <- map["resultCount"]
            tracks <- map["results"]
        }
    }
}

extension Track {
    static func search(with key: String) -> Promise<[Track]> {
        return Promise { (fulfil, reject) in
            Router.search(with: key).request { (response: DataResponse<SearchResponse>) in
                
                guard response.error == nil else {
                    reject(response.error!)
                    return
                }
                
                guard let tracks = response.value?.tracks else {
                    let error = NSError(domain: "JSONResponseError", code: 3841, userInfo: nil)
                    reject(error)
                    return
                }
                
                fulfil(tracks)
            }
        }
    }
}
