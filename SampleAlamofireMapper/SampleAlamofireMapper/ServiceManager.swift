//
//  ServiceManager.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import Alamofire

class ServiceManager {

    static let shared = ServiceManager()
    
    var manager: Alamofire.SessionManager
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders
        self.manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return manager.request(urlRequest)
    }
}

extension ServiceManager {
    struct API {
        static var baseUrl: URL {
//            return URL(string: "http://itunes.apple.com") ?? URL(fileURLWithPath: "")
            return URL(string: "http://10.10.10.158:9111/api/v2") ?? URL(fileURLWithPath: "")
//            http://10.10.10.158:9111/api/v2/guides?locale=en&api_key=fbe941dc3964ef44b24514e5e5df0eda7653cddf
        }
    }
}
