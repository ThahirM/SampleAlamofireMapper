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
