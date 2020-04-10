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
}
