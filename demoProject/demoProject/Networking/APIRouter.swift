//
//  APIRouter.swift
//  BaseProject
//
//  Created by MAC240 on 04/06/18.
//  Copyright © 2018 MAC240. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
}

enum APIRouter: URLRequestConvertible {

    case login(username: String, password: String)
    case hitList(pageNum: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
            
        case .login:
            return .post
        case .hitList:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        let baseUrl = Environment.APIBasePath()
        
        switch self {
        case .login:
            return baseUrl + "account/login"
        case .hitList:
            return baseUrl + ""
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
         case .login(let username, let password):
           return ["UserName": username, "Password": password]
        case .hitList(let pageNum):
            return ["page": pageNum]

        }
    }
    
    func asURLRequest() throws -> URLRequest {
//        let url = try Environment.APIBasePath().asURL()
        
        var urlRequest = URLRequest(url: try path.asURL())
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        //        if (Application.shared.userManager?.authenticationState == .signedIn) {
        //            let token = "Bearer \(Application.shared.userManager?.authToken.value?.accessToken ?? "")"
        //            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        //        }
        
        // Parameters
        if(method != .get) {
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
        } else {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
