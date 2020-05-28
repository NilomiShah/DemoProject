
import UIKit

final class ClientOrCreatorViewModel {
    
    // MARK: - Variables
    private var viewController: ClientOrCreatorViewController
    var clientOrCreatorList: [ClientOrCreatorModel] = []
    var selectedIndex: Int = -1
    init(viewController: ClientOrCreatorViewController) {
        self.viewController = viewController
    }
    
    // MARK: - View Methods
    func prepareView() {
        clientOrCreatorList.append(ClientOrCreatorModel(title: "I want to find work", isSelected: false))
        clientOrCreatorList.append(ClientOrCreatorModel(title: "I want to book a creative", isSelected: false))
        
        viewController.tableviewClientOrCreator.scrollsToTop = false
        viewController.btnSkipContinue.isHidden = true
        
        viewController.viewTitleLabel.attributedText = Utility.getNSAttributedString(fontModel: [FontModel.init(font: UIFont.Calibre.semibold(32.0), color: UIColor(named: "textDark") ?? UIColor.black , text: "What Would You\nLike To Do?")], lineSpacing: 10)
        viewController.viewDescriptionLabel.attributedText = Utility.getNSAttributedString(fontModel: [FontModel.init(font: UIFont.Calibre.regular(20), color: UIColor(named: "textDarkMedium") ?? UIColor.black, text: "Market your creative services to earn cash, book someone for a gig or create two accounts to do both.")])
    }
    
    func manageSkipContinueButtonUI() {
        viewController.btnSkipContinue.isHidden = false
        viewController.btnSkipContinue.setTitle("Continue", for: .normal)
    }
    
    func setProfileData() {
        if let profile = Global.shared.user?.profile,
            let roleIndex = profile.userRole?.intValue,
            let role = UserType(rawValue: roleIndex) {
            switch role {
            case .client:
                selectedIndex = 1
                clientOrCreatorList[1].isSelected = true
                viewController.btnSkipContinue.isHidden = false
            case .creative:
                selectedIndex = 0
                clientOrCreatorList[0].isSelected = true
                viewController.btnSkipContinue.isHidden = false
            default:
                break
            }
            viewController.tableviewClientOrCreator.reloadData()
        }
    }
}

//MARK: - API Calls
extension ClientOrCreatorViewModel {
    func updateUserRoal(navigation: @escaping(_ navigate: Bool) -> Void) {
        viewController.startLoading()
        var role = 0
        if selectedIndex == 0 {
            role = 1
        } else {
            role = 2
        }
      
    }
}

// MARK: - ClientOrCreatorModel
class ClientOrCreatorModel: NSObject {
    var title: String = ""
    var isSelected: Bool = false
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
