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
    
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func didTapOnContinueButton(_ sender: Any) {
    }
    
}
