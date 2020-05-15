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
    
    func setUpView(_ loginButton: UIButton, _ privacyTermsLabel: UILabel) {
        loginButton.addUnderLine(font: UIFont.Calibre.medium(18), color: UIColor.blue)
        privacyTermsLabel.attributedText = "By creating your account you agree to our terms of service and privacy policy".attributedStringWithColor(["terms of service","privacy policy"], font: UIFont.Calibre.medium(14), stringColor: UIColor(named: "termsAndConditions") ?? UIColor.lightGray, color: UIColor.blue)
    }
    
    func setInvalidTextField(_ textField: UITextField) {
        textField.bottomLineColor = UIColor(named: "landingColor3") ?? UIColor.orange
        textField.bottomLineWidth = 2.0
        textField.setCloseButton(image: UIImage(named: "crossOrange") ?? UIImage())
        textField.becomeFirstResponder()
    }
    
    func validEmail(_ emailTextField: UITextField, _ errorEmailLabel: UILabel) {
        emailTextField.bottomLineColor = UIColor(named: "TxtFldBottomBorder") ?? UIColor.lightGray
        emailTextField.bottomLineWidth = 2.0
        emailTextField.rightView = nil
        errorEmailLabel.isHidden = true
    }
    
    func validPassord(_ passwordTextField: UITextField, _ errorPasswordLabel: UILabel) {
        passwordTextField.bottomLineColor = UIColor(named: "TxtFldBottomBorder") ?? UIColor.lightGray
        passwordTextField.bottomLineWidth = 2.0
        setPasswordTextField(passwordTextField)
        errorPasswordLabel.text = "Your password must:\n• be a minimum of 8 characters\n• include one uppercase\n• include one lowercase\n• include one digit"
        errorPasswordLabel.textColor = UIColor(named: "textColor") ?? UIColor.orange
    }
    
    func inValidPassword(_ errorPasswordLabel: UILabel) {
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
            APIManager.shared.callRequest(model: CreateUserResponse.self, APIRouter.createUser(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", FCMPushToken: "", deviceType: ""), onSuccess: { (response) in
                print(response?.user)
            }) { (error) in
                
            }
        }
        
    }
}
extension UIButton {
func addUnderLine(font: UIFont, color: UIColor) {
    if let textTitle = self.titleLabel {
        let attributedcreateaccount = NSMutableAttributedString(
                  string:
            textTitle.text!,
                  attributes: [
                     .font: font,
                     .foregroundColor: color
                   ])
               attributedcreateaccount.addAttribute(.foregroundColor,
                      value: color,
                      range: NSRange(location: 0, length: textTitle.text?.count ?? 0))
                      attributedcreateaccount.addAttribute(NSAttributedString.Key.underlineStyle,
                      value: NSUnderlineStyle.thick.rawValue as Any,
                      range: NSRange(location: 0, length: textTitle.text?.count ?? 0))
        
        self.setAttributedTitle( attributedcreateaccount, for: UIControl.State.normal)
    }
}
}

extension String {
    func attributedStringWithColor(_ strings: [String], font: UIFont, stringColor: UIColor, color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes([.font: font,
                   .foregroundColor: stringColor], range: NSRange(location: 0, length: attributedString.length))
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            attributedString.addAttribute(.foregroundColor,
                                value: color,
                                range: range)
          attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                value: NSUnderlineStyle.thick.rawValue as Any,
                                range: range)
        }
        return attributedString
    }
}
