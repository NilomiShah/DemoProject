//
//  SignUpViewModel.swift
//  demoProject
//
//  Created by PCQ188 on 10/04/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import Foundation
import UIKit
final class SignUpViewModel {
    
    func setPasswordTextField(_ textField: UITextField) {
        if let closeEye = UIImage(named: "eyeClose"), let openEye = UIImage(named: "eye") {
            textField.setPasswordEye(image: closeEye, selectedImage: openEye)
        }
    }
    
    func setValidTextField(_ textField: UITextField) {
        
    }
    
    func setInvalidTextField(_ textField: UITextField) {
        textField.bottomLineColor = UIColor(named: "landingColor3") ?? UIColor.orange
        textField.setCloseButton(image: UIImage(named: "crossOrange") ?? UIImage())
        textField.becomeFirstResponder()
    }
    
    fileprivate func validPassord(_ passwordTextField: UITextField, _ errorPasswordLabel: UILabel) {
        passwordTextField.bottomLineColor = UIColor(named: "TxtFldBottomBorder") ?? UIColor.lightGray
        errorPasswordLabel.text = "Your password must:\n• be a minimum of 8 characters\n• include one uppercase\n• include one lowercase\n• include one digit"
        errorPasswordLabel.textColor = UIColor(named: "textColor") ?? UIColor.orange
    }
    
    fileprivate func inValidPassword(_ errorPasswordLabel: UILabel) {
        errorPasswordLabel.text = "Oops! Your password must be a minimum of 8 characters, with at least one uppercase, one lowercase and one digit"
        errorPasswordLabel.textColor = UIColor(named: "landingColor3") ?? UIColor.orange
    }
    
    func validations(emailTextField: UITextField, passwordTextField: UITextField, errorEmailLabel: UILabel, errorPasswordLabel: UILabel) {
        if (emailTextField.validateEmail() == false) {
            setInvalidTextField(emailTextField)
            errorEmailLabel.isHidden = false
        } else if (passwordTextField.validatePassword() == false) {
            inValidPassword(errorPasswordLabel)
            setInvalidTextField(passwordTextField)
        } else {
            
        }
        
    }
}
extension UIButton {
func addUnderLine(font: UIFont, color: UIColor, underLineColor: UIColor) {
    if let textTitle = self.titleLabel {
        let attributedcreateaccount = NSMutableAttributedString(
                  string:
            textTitle.text!,
                  attributes: [
                     .font: font,
                     .foregroundColor: color
                   ])
               attributedcreateaccount.addAttribute(.foregroundColor,
                      value: underLineColor,
                      range: NSRange(location: 0, length: textTitle.text?.count ?? 0))
                      attributedcreateaccount.addAttribute(NSAttributedString.Key.underlineStyle,
                      value: NSUnderlineStyle.thick.rawValue as Any,
                      range: NSRange(location: 0, length: textTitle.text?.count ?? 0))
        
        self.setAttributedTitle( attributedcreateaccount, for: UIControl.State.normal)
    }
}
}
