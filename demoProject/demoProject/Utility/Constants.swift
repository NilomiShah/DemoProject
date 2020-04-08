//
//  Constants.swift
//  BaseProject
//
//  Created by MAC240 on 04/06/18.
//  Copyright © 2018 MAC240. All rights reserved.
//

import Foundation
import UIKit



//MARK:- Alias for class name
//typealias AppDel            = AppDelegate


//MARK:- Global Variables
let Application = UIApplication.shared.delegate as! AppDelegate
var AppDisplayName: String {return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String}
let Screen                  = UIScreen.main.bounds.size
struct Constants {

    static var KeyWindow : UIWindow? {
           if #available(iOS 13.0, *) {
           return  UIApplication.shared.connectedScenes
               .filter({$0.activationState == .foregroundActive})
               .map({$0 as? UIWindowScene})
               .compactMap({$0})
               .first?.windows
               .filter({$0.isKeyWindow}).first
           } else {
               return UIApplication.shared.keyWindow
           }
       }
    
    //MARK: - device type
    enum UIUserInterfaceIdiom : Int{
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }

}
