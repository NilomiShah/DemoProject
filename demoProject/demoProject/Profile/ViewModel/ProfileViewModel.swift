//
//  ProfileViewModel.swift
//  demoProject
//
//  Created by PCQ184 on 15/05/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import Foundation
import UIKit
final class ProfileViewModel {
    
    var profileURL = ""
    
    func validtion(vc: UIViewController) {
        if let profileViewController = vc as? ProfileViewController {
            if profileViewController.firstNameTextField.trimmedText?.isEmpty == true {
                profileViewController.firstNameTextField.setInvalidTextField()
                profileViewController.firstNameErrorLabel.text = "Please enter first name"
                //                profileViewController.firstNameErrorLabel.isHidden = false
            } else if profileViewController.lastNameTextField.trimmedText?.isEmpty == true {
                profileViewController.lastNameTextField.setInvalidTextField()
                profileViewController.lastNameErrorLabel.text = "Please enter last name"
                //                profileViewController.lastNameErrorLabel.isHidden = false
            } else {
                APIManager.shared.callRequest(model: ProfileResponse.self, APIRouter.updateProfile(profileID: Global.shared.user?.profile?.profileID?.stringValue ?? "", firstName: profileViewController.firstNameTextField.trimmedText ?? "", lastName: profileViewController.lastNameTextField.trimmedText ?? "", company: Global.shared.user?.profile?.company?.stringValue ?? "", profilePhotoURL: profileURL, userRole: "3", fullAddress: Global.shared.user?.profile?.fullAddress?.stringValue ?? "", address1: Global.shared.user?.profile?.address1?.stringValue ?? "", address2: Global.shared.user?.profile?.address2?.stringValue ?? "", city: Global.shared.user?.profile?.city?.stringValue ?? "", state: Global.shared.user?.profile?.state?.stringValue ?? "", zip: Global.shared.user?.profile?.zip?.stringValue ?? "", latitude: Global.shared.user?.profile?.latitude?.stringValue ?? "", longitude: Global.shared.user?.profile?.longitude?.stringValue ?? "", bio: Global.shared.user?.profile?.bio?.stringValue ?? "", jobTitle: Global.shared.user?.profile?.jobTitle?.stringValue ?? ""), onSuccess: { (response) in
                    print(response)
                    vc.navigationController?.pushViewController(UIStoryboard.main.get(TellUsAboutYouViewController.self))
                }) { (error) in
                    
                }
            }
        }
    }
    
    func setUpView(vc: UIViewController) {
        if let profileViewController = vc as? ProfileViewController {
            profileViewController.firstNameTextField.setValidTextField()
            profileViewController.lastNameTextField.setValidTextField()
            profileViewController.companyNameTextField.setValidTextField()
            profileViewController.lastNameErrorLabel.text = ""
            profileViewController.firstNameErrorLabel.text = ""
            profileViewController.companyNameErrorLabel.text = ""
            
        }
    }
    
    func prepareActionSheet(vc: UIViewController) {
        if let profileViewController = vc as? ProfileViewController {
            
            profileViewController.view.endEditing(true)
            let actionSheetController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let takePictureAction = UIAlertAction(title: "Take Photo", style: .default) { (_) in
                //open camera
                profileViewController.openCamera()
            }
            let photoLibraryAction = UIAlertAction(title: "Open Gallery", style: .default) { (_) in
                //Open Photo Library
                profileViewController.openGallery()
            }
            actionSheetController.addAction(cancelAction)
            actionSheetController.addAction(takePictureAction)
            actionSheetController.addAction(photoLibraryAction)
            profileViewController.present(actionSheetController, animated: true, completion: nil)
        }
    }
    
    
}
extension ProfileViewController {
    func openCamera() {
        UIImagePickerController.seekPermission(for: .camera) { (granted) in
            if granted {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            } else {
            }
        }
    }
    func openGallery() {
        UIImagePickerController.seekPermission(for: .photoLibrary) { (bool) in
            if bool == true {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            } else {
            }
        }
    }
}
// MARK: - ImagePicker Delegates
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let img = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true) {
                self.profileImageButton.setImage(img, for: .normal)
                //                self.viewModel.uploadProfilePicture(image: img) { (_) in
                //
                //                }
            }
        }
    }
}
