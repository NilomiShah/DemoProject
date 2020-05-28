
import UIKit
import GoogleMaps
import GooglePlaces

final class TellUsAboutYouViewModel {
    // MARK: - Variables
    private let viewController: TellUsAboutYouViewController
    var isInUpdateMode = false
    
    // MARK: - Setup View Methods
    init(viewController: TellUsAboutYouViewController) {
        self.viewController = viewController
    }
    
    func prepareView() {
        setProfileData()
        viewController.textViewBio.delegate     = viewController
        LocationManger.shared.delegate          = viewController
        LocationManger.shared.statusDelegate    = viewController
        setDefaultLocationButton()
        refreshMasterData()
        viewController.labelError.text = ""
        viewController.buttonCross.isHidden = true
    }
    
    func setProfileData() {
        if let profile = Global.shared.user?.profile {
            if let bio = profile.bio?.stringValue, !bio.isEmpty {
                isInUpdateMode = true
                viewController.textViewBio.text = bio
                viewController.textViewBio.textColor = UIColor(named: "textDark")
                setAddress(profile)
            }
        }
    }
    
    private func setAddress(_ profile: Profile) {
        let placeObject = GooglePlaceData()
        placeObject.latitude            = profile.latitude
        placeObject.longitude           = profile.longitude
        placeObject.fullAddress         = profile.fullAddress
        placeObject.primaryAddress      = profile.address1
        placeObject.secondaryAddress    = profile.address2
        placeObject.city                = profile.city
        placeObject.state               = profile.state
        placeObject.postalCode          = profile.zip
        viewController.currentPlaceObj  = placeObject
        
        var locationString = ""
        if let primaryAddress = profile.address1?.stringValue, !primaryAddress.isEmpty {
            locationString = primaryAddress
            
        } else if let city = profile.city?.stringValue, !city.isEmpty,
            let state = profile.state?.stringValue, !state.isEmpty {
            locationString = "\(city), \(state)"
            
        } else if let city = profile.city?.stringValue, !city.isEmpty {
            locationString = city
        } else if let state = profile.state?.stringValue, !state.isEmpty {
            locationString = state
        } else {
            locationString = ""
        }
        viewController.buttonSearchLocation.setTitle(locationString, for: .normal)
    }
    
    // MARK: - Helper Methods
    private func setDefaultLocationButton() {
        viewController.buttonSearchLocation.setTitle("Search for your address", for: .normal)
        viewController.labelInstructionText.text = "Your address will not be visible to other users"
        viewController.buttonSearchLocation.setImage(UIImage(named: "search")!, for: .normal)
        viewController.buttonSearchLocation.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 0.0)
    }
    
    private func refreshMasterData() {
        if let apiKey = Global.shared.masterData?.googleAPIKey, apiKey.count > 0 {
            setAPIKeys()
            askForLocation()
        } else {
            
                self.askForLocation()
            
        }
    }
    
    private func askForLocation() {
        if LocationManger.shared.isLocationServiceEnabled() {
            !isInUpdateMode ? getCurrentPlace() : ()
        } else {
            createDefaultAddress()
            LocationManger.shared.askForLocationPermission()
        }
    }
    
    func getCurrentPlace() {
        getUserLocationData { (success, place) in
            if success {
                self.setPlaceData(place)
            } else {
                self.viewController.showAlert(title: "App", message: "Failed to fetch location data")
                self.createDefaultAddress()
            }
        }
    }
    
    func createDefaultAddress() {
        let placeObject = GooglePlaceData()
        placeObject.latitude    = 33.7490
        placeObject.longitude   = -84.3880
        placeObject.fullAddress = "Atlanta, GA"
        placeObject.city        = "Atlanta"
        placeObject.state       = "Georgia"
        placeObject.postalCode  = 30060
        viewController.currentPlaceObj = placeObject
        
        viewController.buttonSearchLocation.setTitle("Atlanta, GA", for: .normal)
        
        viewController.buttonSearchLocation.setImage(UIImage(named: "locationGray"), for: .normal)
        viewController.buttonSearchLocation.setTitleColor(UIColor(named: "textDark"), for: .normal)
        viewController.buttonSearchLocation.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        viewController.buttonSearchLocation.borderColor = UIColor.clear
        viewController.labelInstructionText.text = ""
       
    }
    
    func validation() -> Bool {
        let lat = viewController.currentPlaceObj?.latitude?.stringValue ?? ""
        let long = viewController.currentPlaceObj?.longitude?.stringValue ?? ""
        if (viewController.textViewBio.textColor != UIColor(named: "textDark")) || (viewController.textViewBio.text?.trimmed.count == 0) {
            viewController.labelError.text = "EnterBio"
            viewController.viewBioBottomSeparator.backgroundColor = UIColor(named: "appOrange")
            viewController.buttonCross.isHidden = false
            return false
        } else if lat.isEmpty || long.isEmpty {
            viewController.showAlert(title: "Demo App", message: "Select valid location to continue!")
            return false
        }
        return true
    }
}

// MARK: - Google Places Methods
extension TellUsAboutYouViewModel {
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
    
    private func getUserLocationData(responseBlock: @escaping ((Bool, PlaceSearchData)->())) {
        GMSPlacesClient.shared().currentPlace { (result, error) in
            if let error = error {
                print("Autocomplete error \(error)")
                responseBlock(false, PlaceSearchData())
                return
            }
            if let response = result {
                responseBlock(true, PlaceSearchData(currentPlace: response.likelihoods[0]))
            }
        }
    }
    
    func setPlaceData(_ place: PlaceSearchData) {
        viewController.predictedPlaceData = place
        viewController.buttonSearchLocation.setTitle(place.title?.stringValue, for: .normal)
        
        viewController.buttonSearchLocation.setImage(UIImage(named: "locationGray"), for: .normal)        
        
        viewController.buttonSearchLocation.setTitleColor(UIColor(named: "textDark"), for: .normal)
        viewController.buttonSearchLocation.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        viewController.buttonSearchLocation.borderColor = UIColor.clear
        viewController.labelInstructionText.text = ""
        extractPlaceData()
    }
    
    private func extractPlaceData() {
        viewController.predictedPlaceData?.getDetail(completion: { (gmsPlace) in
            if let fetchedObj = gmsPlace {
                let currentPlaceObj = GooglePlaceData(gmsPlace: fetchedObj)
                self.viewController.currentPlaceObj = currentPlaceObj
            } else {
                self.viewController.showAlert(title: "Demo App", message: "Failed to fetch location data")
            }
        })
    }
}

// MARK: - API Calls
extension TellUsAboutYouViewModel {
    func updateBioAndAddress(navigation: @escaping(_ navigate: Bool) -> Void) {
        self.viewController.startLoading()
        
//        TellUsAboutInteractor
//            .updateBioAndAddressDetails(UserProfile.self,
//                                        bio: viewController.textViewBio.text ?? "",
//                                        latitude: viewController.currentPlaceObj?.latitude?.stringValue ?? "",
//                                        longtitude: viewController.currentPlaceObj?.longitude?.stringValue ?? "",
//                                        fulladdress: viewController.currentPlaceObj?.fullAddress?.stringValue ?? "",
//                                        address1: viewController.currentPlaceObj?.primaryAddress?.stringValue ?? "",
//                                        address2: viewController.currentPlaceObj?.secondaryAddress?.stringValue ?? "",
//                                        city: viewController.currentPlaceObj?.city?.stringValue ?? "",
//                                        state: viewController.currentPlaceObj?.state?.stringValue ?? "",
//                                        zipcode: viewController.currentPlaceObj?.postalCode?.stringValue ?? "",
//                                        successCompletion: { (userData) in
//                                            self.viewController.stopLoading()
//                                            if userData.userProfile?.bio?.stringValue != nil{
//                                                var user = Global.shared.user
//                                                let profile = userData.userProfile!
//                                                user?.profile = profile
//                                                user?.syncronize()
//                                                navigation(true)
//                                                return
//                                            }
//                                            navigation(false)
//            }) { (error, resError) in
//                self.viewController.parseAPIError(error, errorRes: resError)
//                navigation(false)
//        }
    }
}
extension TellUsAboutYouViewModel {
    func getUserRole() -> UserType{
        let userRoal = UserType(rawValue: Global.shared.user?.profile?.userRole?.intValue ?? 3) ?? UserType.guest
        return userRoal
    }
}
