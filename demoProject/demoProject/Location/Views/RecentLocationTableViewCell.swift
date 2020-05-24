
import UIKit

class RecentLocationTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var labelAddress: UILabel!
    
    // MARK: - Property Observer
    var addressData: UserSearchData! {
        didSet {
            let locationString = getLocationString(addressData)
            if let address = addressData.address1?.stringValue, !address.isEmpty {
                labelAddress.text = address + ((locationString != "") ?  (", " + locationString) : "")
                
            } else if let city = addressData.city?.stringValue, !city.isEmpty,
                let state = addressData.state?.stringValue, !state.isEmpty {
                labelAddress.text = city + ", " + state
            } else if locationString != "" {
                labelAddress.text = locationString
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helper Methods
    private func getLocationString(_ place: UserSearchData) -> String {
        if let city = place.city?.stringValue, !city.isEmpty {
            return city
        } else if let state = place.state?.stringValue, !state.isEmpty {
            return state
        }
        return ""
    }
}
