//
//  UINavigationController.swift
//  DTY
//
//  Created by MAC240 on 07/06/19.
//  Copyright © 2019 MAC240. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func configureSolidNavigationBar() {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                             NSAttributedString.Key.font: UIFont(name: "CustomFont-Light", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)]
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.red
        navigationBar.tintColor = UIColor.white
        navigationBar.isTranslucent = false
    }
}

extension UIImagePickerController {
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
    }
}
extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
