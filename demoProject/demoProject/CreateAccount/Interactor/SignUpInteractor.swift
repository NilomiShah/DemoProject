//
//  SignUpInteractor.swift
//  demoProject
//
//  Created by PCQ184 on 15/05/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import Foundation
struct SignUpInteractor {
    static func callRequest<Model: Codable>(model: Model.Type,_ router: APIRouter, onSuccess success: @escaping (_ response: Model?) -> Void, onFailure failure: @escaping (_ error: APICallError) -> Void) {
        APIManager.shared.callRequest(model: model, router, onSuccess: success, onFailure: failure)
    }
}
