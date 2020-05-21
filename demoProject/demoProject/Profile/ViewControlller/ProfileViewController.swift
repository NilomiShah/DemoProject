//
//  ProfileViewController.swift
//  demoProject
//
//  Created by PCQ184 on 15/05/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var lastNameErrorLabel: UILabel!
    @IBOutlet weak var companyNameErrorLabel: UILabel!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    @IBOutlet weak var profileImageButton: UIButton!
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func didTapOnContinueButton(_ sender: Any) {
        if(profileImageButton.currentBackgroundImage == nil) {
            let avatarVC = UIStoryboard.main.get(SelectProfileViewController.self)
            avatarVC.modalPresentationStyle = .overFullScreen
            avatarVC.modalTransitionStyle = .crossDissolve
            self.present(avatarVC, animated: true, completion: nil)
        } else {
            viewModel.validtion(vc: self)
        }
    }
    @IBAction func didTapOnProfileButton(_ sender: Any) {
        self.viewModel.prepareActionSheet(vc: self)
    }
    
    func setUp() {
        self.viewModel.setUpView(vc: self)
    }
    
}
// MARK: - TextField Delegate
extension ProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.viewModel.setUpView(vc: self)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
