//
//  UIStoryboard+Controllers.swift
//  BaseProject
//
//  Created by MAC240 on 04/06/18.
//  Copyright © 2018 MAC240. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {

    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var registration: UIStoryboard {
        return UIStoryboard(name: "Registration", bundle: nil)
    }
    var identifier: String {
        if let name = self.value(forKey: "name") as? String {
            return name
        }
        return ""
    }

    /// Get view controller from storyboard by its class type
    /// Warning: identifier should match storyboard ID in storyboard of identifier class
    public func get<T:UIViewController>(_ identifier: T.Type) -> T {
        let storyboardID = String(describing: identifier)

        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError(String(describing: T.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
}


extension UIStoryboard {
//
//    var hitsViewController: HitsViewController {
//        return UIStoryboard.main.get(HitsViewController.self)
//    }
//    
//    var hitsDetailViewController: HitsDetailViewController {
//        return UIStoryboard.main.get(HitsDetailViewController.self)
//    }
    
}
