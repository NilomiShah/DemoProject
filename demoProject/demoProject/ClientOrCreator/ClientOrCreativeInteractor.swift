//
//  ClientOrCreativeInteractor.swift
//  TMRO
//
//  Created by pcq196 on 02/03/20.
//  Copyright © 2020 Sagar Prajapati. All rights reserved.
//

import Foundation
struct ClientOrCreativeInteractor {
    static func callRequest<Model: Codable>(model: Model.Type,_ router: APIRouter, onSuccess success: @escaping (_ response: Model?) -> Void, onFailure failure: @escaping (_ error: APICallError) -> Void) {
        APIManager.shared.callRequest(model: model, router, onSuccess: success, onFailure: failure)
    }
}
/*
struct ClientOrCreativeInteractor {
    static func updateUserRoal<T: Codable>(_ type: T.Type, userRole:Int, successCompletion: @escaping (_ response: T) -> Void, failureCompletion: @escaping failure)  {
        
        let parameter: [String: Any] = [
            "ProfileID": Global.shared.user?.profile?.profileID?.stringValue ?? "0",
            "FirstName" : Global.shared.user?.profile?.firstName?.stringValue ?? "",
            "LastName" : Global.shared.user?.profile?.lastName?.stringValue ?? "",
            "Company":Global.shared.user?.profile?.company?.stringValue ?? "",
            "FullAddress": Global.shared.user?.profile?.fullAddress?.stringValue ?? "",
            "ProfilePhotoURL":Global.shared.user?.profile?.profilePhotoURL?.stringValue ?? "",
            "Address1": Global.shared.user?.profile?.address1?.stringValue ?? "",
            "Address2": Global.shared.user?.profile?.address2?.stringValue ?? "",
            "City": Global.shared.user?.profile?.city?.stringValue ?? "",
            "State": Global.shared.user?.profile?.state?.stringValue ?? "",
            "Zip": Global.shared.user?.profile?.zip?.stringValue ?? "",
            "Latitude": Global.shared.user?.profile?.latitude?.stringValue ?? "",
            "Longitude": Global.shared.user?.profile?.longitude?.stringValue ?? "",
            "Bio": Global.shared.user?.profile?.bio?.stringValue ?? "",
            "UserRole": "\(userRole)",
            "JobTitle" : Global.shared.user?.profile?.jobTitle?.stringValue ?? ""
        ]
        
        print(parameter)
        Web.sendRequest(.updateProfile(parameter), type: T.self, successCompletion: successCompletion , failureCompletion: failureCompletion)
    }
}
*/
