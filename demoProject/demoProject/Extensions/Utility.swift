//
//  Utility.swift
//  demoProject
//
//  Created by PCQ184 on 15/05/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import Foundation
import Foundation
import IQKeyboardManagerSwift
final class Device {
    
    class var isInTestFlight: Bool {
        // http://stackoverflow.com/questions/12431994/detect-testflight
        return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }
    class var type: String {
        return "1"
    }
    class var operatingSystem: String {
        return UIDevice.current.systemVersion
    }
    class var screenSize : CGSize {
        return UIScreen.main.bounds.size
    }
    
    class var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var uniqueIdentifier: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }

    /// Gets the identifier from the system, such as "iPhone7,1".
    private static var identifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
}

// MARK:- UserDefault Methods

func setUserDefault(ObjectToSave : AnyObject?  , KeyToSave : String) {
    let defaults = UserDefaults.standard
    
    if (ObjectToSave != nil)
    {
        
        defaults.set(ObjectToSave as? Data, forKey: KeyToSave)
    }
    
    UserDefaults.standard.synchronize()
}

func getUserDefault(KeyToReturnValye : String) -> AnyObject? {
    let defaults = UserDefaults.standard
    
    if let name = defaults.value(forKey: KeyToReturnValye)
    {
        return name as AnyObject?
    }
    return nil
}
