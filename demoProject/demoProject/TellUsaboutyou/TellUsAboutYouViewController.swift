
import UIKit
import CoreLocation
import GooglePlaces

class TellUsAboutYouViewController: BaseViewController {
    
    // MARK: - Outlets -
    @IBOutlet weak var buttonSearchLocation     : UIButton!
    @IBOutlet weak var labelInstructionText     : UILabel!
    @IBOutlet weak var textViewBio              : UITextView!
    @IBOutlet weak var labelError               : UILabel!
    @IBOutlet weak var viewBioBottomSeparator   : UIView!
    @IBOutlet weak var buttonCross              : UIButton!
    
    // MARK: - Variables -
    lazy private var viewModel  = TellUsAboutYouViewModel(viewController: self)
    var predictedPlaceData      : PlaceSearchData?
    var currentPlaceObj         : GooglePlaceData?
    private var isLinkProfileMode       = false
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        viewModel.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setProfileData()
        isLinkProfileMode = (Global.shared.user?.profileRolesList?.count ?? 0 == 2) ? true : false
    }
    
    // MARK: - Action Methods -
    @IBAction private func didTapOnSearchLocation() {
        viewModel.openPlacePicker()
    }
    
    @IBAction private func didTapOnContinue() {
        if viewModel.validation() {
            self.viewModel.updateBioAndAddress { (navigate) in
                let role = self.viewModel.getUserRole()
                if role == .client && self.isLinkProfileMode {
//                    self.viewNavigator.moveToJobTitle()
                } else if role == .creative && self.isLinkProfileMode {
//                    self.viewNavigator.moveToListSerives()
                } else {
//                    self.viewNavigator.moveToClientOrCreative()
                }                
            }
        }
    }
    
    @IBAction private func didOnBack() {
        self.navigationController?.popViewController()
    }
    
}

// MARK: - TextView Delgate Methods -
extension TellUsAboutYouViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor != UIColor(named: "textDark") {
            textView.text = ""
            textView.textColor = UIColor(named: "textDark")
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.trimmed.count == 0 {
            textView.text = "Tell us about yourself (max 50 characters) "
            textView.textColor = UIColor(named: "TextGrey")
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        labelError.text = ""
        buttonCross.isHidden = true
        viewBioBottomSeparator.backgroundColor = UIColor(named: "appBorder")
        guard let prospectiveText = textView.text,
            prospectiveText.count > 50
            else {
                return
        }
        let selection = textView.selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: 50)
        textView.text = String(prospectiveText[..<maxCharIndex])
        textView.selectedTextRange = selection
    }
    
}

// MARK: - Location Status Delegate
extension TellUsAboutYouViewController: LocationServiceDelegate, LocationServiceStatusDelegate {
    func didGrantPermission(_ isGranted: Bool) {
        if isGranted {
            !viewModel.isInUpdateMode ? viewModel.getCurrentPlace() : ()
        } else {
            viewModel.createDefaultAddress()
        }
    }
    func didUpdateLocation(location: CLLocation) {
        !viewModel.isInUpdateMode ? viewModel.getCurrentPlace() : ()
        LocationManger.shared.stopUpdatingLocation()
    }
}

// MARK: - GooglePlaces Delegates
extension TellUsAboutYouViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didSelect prediction: GMSAutocompletePrediction) -> Bool {
        let predictedPlace = PlaceSearchData(prediction: prediction)
        viewModel.setPlaceData(predictedPlace)
        return true
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
