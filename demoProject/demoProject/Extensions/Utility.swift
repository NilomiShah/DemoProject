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
import Photos
import SwiftMessages

let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!

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
enum FileFormate: String {
    
    case png = ".png"
    case jpeg = ".jpeg"
    case mov = ".mov"
    
    var extention:String{
        return self.rawValue
    }
    func getMediaExtention(type : PHAssetMediaType) -> String? {
        if type == .image {
            return ".png"
        } else if type == .video {
            return ".mov"
        }
        return nil
    }
}

enum ImageFormate: String {
    case png = ".png"
    case jpeg = ".jpeg"
    
    var extention:String{
        return self.rawValue
    }
}
enum UserType: Int, CaseIterable {
    case none
    case creative
    case client
    case guest
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .creative:
            return "Creative Profile"
        case .client:
            return "Client Profile"
        case .guest:
            return "Guest Profile"
        }
    }
    var Id: String {
        switch self {
        case .none:
            return "0"
        case .creative:
            return "1"
        case .client:
            return "2"
        case .guest:
            return "3"
        }
    }
}

struct FontModel {
    
    var font    : UIFont    = UIFont()
    var color   : UIColor   = .clear
    var text    : String    = ""
    
    init(font : UIFont, color : UIColor, text : String) {
        self.font   = font
        self.color  = color
        self.text   = text
    }
    
}

class Utility {
    
    // MARK: - Alert methods
    class func showAlert(title: String = "TmrO", message: String?, preferredStyle: UIAlertController.Style = .alert, actions: UIAlertAction..., viewController: UIViewController = UIViewController()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        DispatchQueue.main.async {
            appDelegate.window?.rootViewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlertOnViewController(title: String = "TmrO", message: String?, preferredStyle: UIAlertController.Style = .alert, actions: UIAlertAction..., viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    class func getAttributeTextWithLineSpaceing(_ lineSpacing: CGFloat, string: String, alighment: NSTextAlignment = .center, color : UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing // Whatever line spacing you want in points
        paragraphStyle.alignment = alighment
        let newRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: newRange)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: newRange)
        return attributedString
    }
    class func getClassNameFor(classType: Any) -> String {
        let typeOfClass = type(of: classType)
        return String(describing: typeOfClass)
    }
    
    class func getUniqFileName(fileType: FileFormate) -> String {
        let name = UUID().uuidString
        return name + fileType.extention
    }
    
    class func getNSAttributedString(fontModel : [FontModel], lineSpacing: CGFloat = 0, textAlignment : NSTextAlignment = .center) -> NSMutableAttributedString {
        let combinationMessage = NSMutableAttributedString()
        for fontModelObject in fontModel {
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment    = textAlignment
            paragraphStyle.lineSpacing  = lineSpacing
            
            let attributedStyle =   [
                NSAttributedString.Key.font             : fontModelObject.font,
                NSAttributedString.Key.foregroundColor  : fontModelObject.color,
                NSAttributedString.Key.paragraphStyle   : paragraphStyle
            ]
            
            let stringText = NSMutableAttributedString(string: fontModelObject.text, attributes: attributedStyle)
            combinationMessage.append(stringText)
        }
        return combinationMessage
    }
    
    class func convertToJSONString(value: [Any]) -> String? {
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string.replacingOccurrences(of: "\"", with: "") as String
                }
            }catch{
            }
        }
        return nil
    }
    
    class func showSuccessMessage(message : String) {
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureContent(title: "Success", body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .center
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(view: success)
    }
    
    class func showErrorToastMessage(message : String) {
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.error)
        success.configureDropShadow()
        success.configureContent(title: "Error", body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .center
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(view: success)
    }
    
    class func calculateServiceRate(_ hourlyRate: Int, totalHours: Int) -> Double {
        let appFeePercent = 0.1 // 10%
        let otherFeePercent = 0.029 // 2.9%
        let otherFixedPercent = 0.3
        let totalValue = hourlyRate * totalHours
        let den = (Double(totalValue) * (1 - appFeePercent)) + otherFixedPercent
        return den / (1 - otherFeePercent)
    }
}
