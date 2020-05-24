//
//  GooglePlacesHelper.swift
//  TMRO
//
//  Created by Atri Patel on 23/03/20.
//  Copyright © 2020 Sagar Prajapati. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class GooglePlacesHelper {
    ///Shared Instance
    static let shared = GooglePlacesHelper()
    
    func getUserLocationData(responseBlock: @escaping ((Bool, GooglePlaceData?) -> Void)) {
        GMSPlacesClient.shared().currentPlace { (result, error) in
            if let error = error {
                print("Autocomplete error \(error)")
                responseBlock(false, nil)
                return
            }
            if let response = result {
                self.extractPlaceData(PlaceSearchData(currentPlace: response.likelihoods[0]),
                                      responseBlock: responseBlock)
            }
        }
    }
    
    func extractPlaceData(_ placeData: PlaceSearchData, responseBlock: @escaping ((Bool, GooglePlaceData?) -> Void)) {
        placeData.getDetail(completion: { (gmsPlace) in
            if let fetchedObj = gmsPlace {
                let currentPlaceObj = GooglePlaceData(gmsPlace: fetchedObj)
                responseBlock(true, currentPlaceObj)
            } else {
                responseBlock(false, nil)
            }
        })
    }
}
