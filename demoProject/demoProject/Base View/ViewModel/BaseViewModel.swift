//
//  BaseViewModel.swift
//  demoProject
//
//  Created by PCQ184 on 20/05/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import Foundation
import UIKit

final class BaseViewModel {
    
    func callMasterApi(_  completion: @escaping (_ success: Bool) -> Void) {
        APIManager.shared.callRequest(model: MasterResponse.self, APIRouter.getConfigurationDetail, onSuccess: { response in
            setUserDefault(ObjectToSave: response as AnyObject?, KeyToSave: Key.masterdata)
            Global.shared.masterData = response
            completion(true)
        }) { (error) in
            completion(true)
        }
    }
}
