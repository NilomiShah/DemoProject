//
//  PlaceSearch.swift
//  TMRO
//
//  Created by PCQ184 on 20/02/20.
//  Copyright © 2020 Sagar Prajapati. All rights reserved.
//

import Foundation
import GooglePlaces

struct PlaceSearchData: Codable {
    var id              : Generic?
    var name            : Generic?
    var lat             : Generic?
    var long            : Generic?
    var title           : Generic?
    var subTitle        : Generic?
    
    init() {
        id              = ""
        name            = ""
        lat             = ""
        long            = ""
        title           = ""
        subTitle        = ""
    }
    
    //For Handling google places results
    init(prediction: GMSAutocompletePrediction) {
        id              =   Generic(prediction.placeID)
        title           =   Generic(prediction.attributedPrimaryText.string)
        subTitle        =   Generic(prediction.attributedSecondaryText?.string)
    }
    
    init(currentPlace: GMSPlaceLikelihood) {
        id      = Generic(currentPlace.place.placeID)
        title   = Generic(currentPlace.place.formattedAddress)
        lat     = Generic(currentPlace.place.coordinate.latitude)
        long    = Generic(currentPlace.place.coordinate.longitude)
    }
    
    init(currentPlace: GMSPlace) {
        id      = Generic(currentPlace.placeID)
        title   = Generic(currentPlace.formattedAddress ?? currentPlace.name)
        lat     = Generic(currentPlace.coordinate.latitude)
        long    = Generic(currentPlace.coordinate.longitude)
    }
    
    func getDetail(completion:((GMSPlace?)->Void)?) {
        let placesClient = GMSPlacesClient()
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        filter.country = "US"
        
        placesClient.lookUpPlaceID(self.id?.stringValue ?? "") { (place, error) in
            completion?(place)
        }
    }
}

class GooglePlaceData: Codable {
    var fullAddress         : Generic?
    var primaryAddress      : Generic?
    var secondaryAddress    : Generic?
    var city                : Generic?
    var cityShortName       : Generic?
    var state               : Generic?
    var stateShortName      : Generic?
    var country             : Generic?
    var countryShortName    : Generic?
    var postalCode          : Generic?
    var latitude            : Generic?
    var longitude           : Generic?
    
    init() {
        fullAddress         = ""
        primaryAddress      = ""
        secondaryAddress    = ""
        city                = ""
        cityShortName       = ""
        state               = ""
        stateShortName      = ""
        country             = ""
        countryShortName    = ""
        postalCode          = ""
        latitude            = ""
        longitude           = ""
    }
    
    init(gmsPlace: GMSPlace) {
        if let addComponents = gmsPlace.addressComponents {
            var primaryAddressDict = [String: String]()
            for addressComponent in addComponents {
                if addressComponent.types[0] == "country"{
                    country             = Generic(addressComponent.name)
                    countryShortName    = Generic(addressComponent.shortName)
                    
                } else if addressComponent.types[0] == "administrative_area_level_1" {
                    state           = Generic(addressComponent.name)
                    stateShortName  = Generic(addressComponent.shortName)
                    
                } else if addressComponent.types[0] == "locality" {
                    city            = Generic(addressComponent.name)
                    cityShortName   = Generic(addressComponent.shortName)
                    
                }  else if addressComponent.types[0] == "postal_code" {
                    postalCode      = Generic(addressComponent.name)
                    
                } else if addressComponent.types[0] == "sublocality_level_1" {
                    primaryAddressDict["locality"] = addressComponent.name
                    //primaryAddress  = Generic(addressComponent.name)
                    
                } else if addressComponent.types[0] == "sublocality_level_2" {
                    secondaryAddress    = Generic(addressComponent.name)
                    
                } else if addressComponent.types[0] == "street_number" {
                    primaryAddressDict["street"] = addressComponent.name
                    
                } else if addressComponent.types[0] == "route" {
                    primaryAddressDict["route"] = addressComponent.name
                }
            }
            ///Create primary address
            var addressCompArray = [String]()
            if let street = primaryAddressDict["street"] {
                addressCompArray.append(street)
            }
            if let route = primaryAddressDict["route"] {
                addressCompArray.append(route)
            }
            if let locality = primaryAddressDict["locality"] {
                addressCompArray.append(locality)
            }
            primaryAddress = Generic(addressCompArray.toString())
        }
        
        if let fullAdd = gmsPlace.formattedAddress {
            fullAddress = Generic(fullAdd)
        }
        
        latitude    =   Generic(gmsPlace.coordinate.latitude)
        longitude   =   Generic(gmsPlace.coordinate.longitude)
    }
    
    init(recentPlaceSearch: UserSearchData) {
        primaryAddress      = recentPlaceSearch.address1
        secondaryAddress    = recentPlaceSearch.address2
        city                = recentPlaceSearch.city
        state               = recentPlaceSearch.state
        postalCode          = recentPlaceSearch.zip
        latitude            = recentPlaceSearch.lat
        longitude           = recentPlaceSearch.long
    }
}
