
import Foundation
import GoogleMaps
import GooglePlaces

final class ChangeLocationViewModel {
    // MARK: - Variables
    private let viewController: ChangeLocationViewController
    var recentSearchData = [UserSearchData]()
    
    // MARK: - Setup View Methods
    init(viewController: ChangeLocationViewController) {
        self.viewController = viewController
    }
    

}

// MARK: - Google Places Methods
extension ChangeLocationViewModel {
    func openPlacePicker() {
        let autocompleteController          = GMSAutocompleteViewController()
        autocompleteController.delegate     = viewController
        let fields: GMSPlaceField           = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields  = fields
        let filter                          = GMSAutocompleteFilter()
        filter.type                         = .address
        filter.country                      = "US"
        autocompleteController.autocompleteFilter       = filter
        autocompleteController.modalPresentationStyle   = .overFullScreen
        viewController.present(autocompleteController, animated: true, completion: nil)
    }
    
    func extractPlaceData(_ placeData: PlaceSearchData) {
        GooglePlacesHelper
            .shared
            .extractPlaceData(placeData) { (success, placeDtl) in
                if success,
                    let place = placeDtl {
                    if self.viewController.placeData != nil {
                        self.viewController.placeData!(place)
                        self.viewController.navigationController?.popViewController()
                    }
                } else {
                    
                }
        }
    }
    
    func getCurrentPlaceData() {
        GooglePlacesHelper
            .shared
            .getUserLocationData { (success, data) in
                if success,
                    let place = data {
                    self.viewController.buttonSearchLocation.setTitle(place.city?.stringValue, for: .normal)

                    if self.viewController.placeData != nil {
                        self.viewController.butonCurrentLocation.setTitle(place.city?.stringValue, for: .normal)
                        self.viewController.placeData!(place)
                    }
                } else {
                  
                }
        }
    }
}
