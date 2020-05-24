
import UIKit
import CoreLocation
import GooglePlaces

class ChangeLocationViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var buttonSearchLocation     : UIButton!
    @IBOutlet weak var butonCurrentLocation     : UIButton!
    @IBOutlet weak var tableViewRecentSearch    : UITableView!
    
    // MARK: - Variables
    lazy private var viewModel  = ChangeLocationViewModel(viewController: self)
    var searchFor               = SearchFor.none
    var placeData: ((GooglePlaceData) -> Void)?
    var jobID:  String?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action Methods
    @IBAction private func didTapOnSearchLocation(_ sneder: UIButton) {
        viewModel.openPlacePicker()
    }
    
    @IBAction private func didTapOnGoBack(_ sneder: UIButton) {
        self.navigationController?.popViewController()
    }
    
    @IBAction private func didTapOnCurrentLocation(_ sender: UIButton) {
        if LocationManger.shared.isLocationServiceEnabled() {
            viewModel.getCurrentPlaceData()
        } else {
        }
    }
}

// MARK: - Table View Delegate Datasource Methods
extension ChangeLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.registerAndGet(cell: RecentLocationTableViewCell.self)
        cell?.addressData = viewModel.recentSearchData[indexPath.row]
        return cell ?? RecentLocationTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = GooglePlaceData(recentPlaceSearch: viewModel.recentSearchData[indexPath.row])
        if placeData != nil {
            placeData!(selectedPlace)
            self.navigationController?.popViewController()
        }
    }
}

// MARK: - GooglePlaces Delegates
extension ChangeLocationViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController,
                        didSelect prediction: GMSAutocompletePrediction) -> Bool {
        let predictedPlace = PlaceSearchData(prediction: prediction)
        viewModel.extractPlaceData(predictedPlace)
        return true
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
