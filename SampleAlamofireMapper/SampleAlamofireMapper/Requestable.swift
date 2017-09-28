//
//  Requestable.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol Requestable: URLRequestConvertible {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    
    func request<T: BaseMappable>(with responseObject:@escaping (DataResponse<T>) -> Void)
    func request<T: BaseMappable>(with responseArray:@escaping (DataResponse<[T]>) -> Void)
}

extension Requestable {
    
    func request<T: BaseMappable>(with responseObject:@escaping (DataResponse<T>) -> Void) {
        ServiceManager.shared.request(self).responseObject(completionHandler: responseObject).validate()
    }
    
    func request<T: BaseMappable>(with responseArray:@escaping (DataResponse<[T]>) -> Void) {
        ServiceManager.shared.request(self).responseArray(completionHandler: responseArray).validate()
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlRequest = try URLRequest(url: ServiceManager.API.baseUrl.appendingPathComponent(path), method: method, headers: ServiceManager.shared.manager.session.configuration.httpAdditionalHeaders as? HTTPHeaders ?? [:])
        return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
