
import UIKit

class ClientOrCreatorViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableviewClientOrCreator : UITableView!
    @IBOutlet weak var btnSkipContinue          : UIButton!
    @IBOutlet weak var viewTitleLabel           : UILabel!
    @IBOutlet weak var viewDescriptionLabel     : UILabel!
    
    // MARK: - Variables
    lazy var viewModel      = ClientOrCreatorViewModel(viewController: self)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setProfileData()
    }
    
    // MARK: - Action Methods
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    @IBAction func didTapOnSkipContinueButton(_ sender: Any) {
        viewModel.updateUserRoal { (navigate) in
            
        }
    }
    

    
}
// MARK: - Tableview
extension ClientOrCreatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.clientOrCreatorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.registerAndGet(cell: RadioTableViewCell.self)!
        cell.setData = viewModel.clientOrCreatorList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for model in viewModel.clientOrCreatorList {
            model.isSelected = false
        }
        viewModel.selectedIndex = indexPath.row
        viewModel.clientOrCreatorList[indexPath.row].isSelected = !viewModel.clientOrCreatorList[indexPath.row].isSelected
        viewModel.manageSkipContinueButtonUI()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}

