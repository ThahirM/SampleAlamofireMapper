//
//  BaseMappable.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import ObjectMapper

class BaseMappable: Mappable {
    required init?(map: Map) {}
    func mapping(map: Map) {}
}
