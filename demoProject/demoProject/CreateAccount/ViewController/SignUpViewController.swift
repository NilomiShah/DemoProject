//
//  SignUpViewController.swift
//  TMRO
//
//  Created by pcq196 on 21/01/20.
//  Copyright © 2020 pcq196. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var privacyTermsLabel    : UILabel!
    @IBOutlet weak var loginButton          : UIButton!
    @IBOutlet weak var scrollView           : UIScrollView!
    @IBOutlet weak var backButton           : UIButton!
    @IBOutlet weak var crossButton          : UIButton!
    @IBOutlet weak var emailTextField       : UITextField!
    @IBOutlet weak var passwordTextField    : UITextField!
    @IBOutlet weak var errorEmailLabel      : UILabel!
    @IBOutlet weak var errorPasswordLabel   : UILabel!

    var viewModel = SignUpViewModel()
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
     }
    
    func setUpUI() {
        viewModel.setPasswordTextField(passwordTextField)
        viewModel.setUpView(loginButton, privacyTermsLabel)
        scrollView.delegate = self
    }
    
    func navigateTo(objVC: UIViewController) {
        self.navigationController?.pushViewController(objVC)
    }
    // MARK: - Action Methods
    @IBAction private func didTapOnLoginHere() {
    }
    @IBAction private func didTapOnCreateAccount() {
        viewModel.validations(emailTextField: emailTextField, passwordTextField: passwordTextField, errorEmailLabel: errorEmailLabel, errorPasswordLabel: errorPasswordLabel, viewcontroller: self)
   
    }
    @IBAction private func didTapOnBack() {
        self.navigationController?.popViewController()
    }
    @IBAction private func didTapOnCross() {
    }
    @IBAction private func didTapOnClearEmail() {
    }
    @IBAction private func didTapOnClearPassword() {
    }
    
}
// MARK: - ScrollView Delegate
extension SignUpViewController: UIScrollViewDelegate {
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
          if scrollView.contentOffset.y < 0 {
            return false
          }
          return true
    }
}
// MARK: - TextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.validEmail(emailTextField, errorEmailLabel)
        viewModel.validPassord(passwordTextField, errorPasswordLabel)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
