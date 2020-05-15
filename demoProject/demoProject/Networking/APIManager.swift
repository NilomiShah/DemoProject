//
//  APIManager.swift
//  BaseProject
//
//  Created by MAC240 on 04/06/18.
//  Copyright © 2018 MAC240. All rights reserved.
//

import Foundation
import Alamofire


class APIManager {

    /// Custom header field
    var header  = ["Content-Type":"application/json"]

    static let shared:APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager:Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        sessionManager = Alamofire.Session(configuration: configuration)
    }
    
    /// Set Bearer token with this method
    func setToken(authorizeToken : String) {
        self.header["Authorization"] = "Bearer \(authorizeToken)"
    }
    
    /// Remove Bearer token with this method
    func removeAuthorizeToken() {
        self.header.removeValue(forKey: "Authorization")
    }

      
    func callRequest<Model: Codable>(model: Model.Type,_ router: APIRouter, onSuccess success: @escaping (_ response: Model?) -> Void, onFailure failure: @escaping (_ error: APICallError) -> Void) {
        
            guard Application.reachability.isReachable == true else {
                let apiError = APICallError(status: .offline)
                failure(apiError)
                return
            }
        var parameter = router.parameters
                   if router.parameters == nil {
                       parameter = [:]
                   }
        self.sessionManager.request(router).response { response  in
                        
                        switch response.result {
                        case .success:
                            do {
                                print(String(decoding: response.data ?? Data(), as: UTF8.self))
                                let decoder = JSONDecoder()
                                let dictResponse = try decoder.decode(model, from: response.data ?? Data())
                                DispatchQueue.main.async {
                                    success(dictResponse)
                                }
                            } catch (let parsingError) {
                                print(parsingError)
                                success(nil)
                            }
                            break
                        case .failure(let error):
                            print("Error: \(error)")
                            let apiError = APICallError(status: .failed)
                            failure(apiError)
                            break
                        }
                    }
        }
      
        func callRequestWithMultipartData<Model: Codable>(model: Model.Type,_ router: APIRouter, arrImages: [UIImage]?, onSuccess success: @escaping (_ response: Model?) -> Void, onFailure failure: @escaping (_ error: APICallError) -> Void) {
                        
            var parameter = router.parameters
            if router.parameters == nil {
                parameter = [:]
            }
            
            let headers: HTTPHeaders = [
                /* "Authorization": "your_access_token",  in case you need authorization header */
                "Authorization": self.header["Authorization"]!,
                "Content-type": "multipart/form-data"
            ]
            
            self.sessionManager.upload(multipartFormData: { multipartFormData in
                
                for image in arrImages! {
                    if let imageData = image.pngData() {
                        multipartFormData.append(imageData, withName: "user[profile_picture]", fileName: "test.png", mimeType: "image/png")
                    }
                }
                
                for (key, value) in parameter! {
                    multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
                }
            }, to: router.path, usingThreshold: UInt64.init(), method: router.method , headers: headers).responseJSON { (response) in
                plog(response.value)
                switch response.result {
                case .success:
                    
                    do {
                        let decoder = JSONDecoder()
                        let dictResponse = try decoder.decode(model, from: response.data ?? Data())
                        DispatchQueue.main.async {
                            success(dictResponse)
                        }
                    } catch (let parsingError) {
                        print(parsingError)
                        success(nil)
                    }
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    let apiError = APICallError(status: .failed)
                    failure(apiError)
                    break
                }
            }
        }
        
  
    //MARK:- Cancel Requests
    
    func cancelAllTasks() {
        self.sessionManager.session.getAllTasks { tasks in
            tasks.forEach {
                $0.cancel()
            }
        }
    }
    
    func cancelRequests(url: String) {
        self.sessionManager.session.getTasksWithCompletionHandler
            {
                (dataTasks, uploadTasks, downloadTasks) -> Void in
                
                self.cancelTasksByUrl(tasks: dataTasks     as [URLSessionTask], url: url)
                self.cancelTasksByUrl(tasks: uploadTasks   as [URLSessionTask], url: url)
                self.cancelTasksByUrl(tasks: downloadTasks as [URLSessionTask], url: url)
        }
    }
    
    private func cancelTasksByUrl(tasks: [URLSessionTask], url: String) {
        
        for task in tasks {
            if task.currentRequest?.url?.absoluteString == url {
                task.cancel()
            }
        }
    }
    
}
