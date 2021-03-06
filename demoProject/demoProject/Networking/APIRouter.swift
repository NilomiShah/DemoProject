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

    case createUser(email: String, password: String, FCMPushToken: String, deviceType: String)
    case getConfigurationDetail
    case updateProfile(profileID: String, firstName: String, lastName: String, company: String, profilePhotoURL: String, userRole: String, fullAddress: String, address1 : String, address2: String, city: String, state: String, zip: String, latitude: String, longitude: String, bio: String, jobTitle: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .createUser,.updateProfile:
            return .post
        case .getConfigurationDetail:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        let baseUrl = Environment.APIBasePath()
        
        switch self {
        case .createUser:
            return baseUrl + "RegisterUser"
        case .getConfigurationDetail:
            return baseUrl + "GetConfigurationDetail"
        case .updateProfile:
            return baseUrl + "UpdateUserProfile"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .createUser(let email, let password, let FCMPushToken, let deviceType):
            return ["Email" : email, "Password" : password, "FCMPushToken" : "", "DeviceType" : "1","DeviceIdentifier" : Device.uniqueIdentifier ,"DeviceOS" : "13.2"]
        case .getConfigurationDetail:
            return [:]
        case .updateProfile(let profileID, let firstName, let lastName, let company, let profilePhotoURL, let userRole, let fullAddress, let address1, let address2, let city, let state, let zip, let latitude, let longitude, let bio, let jobTitle):
            return [
                "ProfileID": profileID,
                "FirstName": firstName,
                "LastName": lastName,
                "Company": company,
                "ProfilePhotoURL": profilePhotoURL,
                "UserRole":"\(userRole)",
                "FullAddress": fullAddress,
                "Address1": address1 ,
                "Address2":address2,
                "City": city ,
                "State": state ,
                "Zip": zip,
                "Latitude": latitude,
                "Longitude": longitude,
                "Bio": bio ,
                "JobTitle": jobTitle
            ]
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

        if (Global.shared.user?.token != nil) {
                    let token = "Bearer \(Global.shared.user?.token ?? "")"
                    urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
                }
        
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
