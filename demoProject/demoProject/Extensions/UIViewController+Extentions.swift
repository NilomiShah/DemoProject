//
//  UIViewController+Extentions.swift
//  TMRO
//
//  Created by pcq196 on 14/02/20.
//  Copyright © 2020 Sagar Prajapati. All rights reserved.
//

import UIKit
import ObjectiveC

enum AlertType: String {
    case Error = "Error"
    case AppTitle = "Demo"
}
extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        for vc in self.viewControllers {
            if vc.isKind(of: ofClass){
                popToViewController(vc, animated: animated)
            }
        }
    }
    func viewController(ofClass: AnyClass) -> Bool {
       for vc in self.viewControllers {
           if vc.isKind(of: ofClass){
               return true
           }
       }
    return false
   }
     func getViewController(ofClass: AnyClass) -> UIViewController? {
        for vc in self.viewControllers {
            if vc.isKind(of: ofClass){
                return vc
            }
        }
        return nil
    }
    func pop(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
          self.addTransition(transitionType: type, duration: duration)
          self.popViewController(animated: false)
      }

      /**
       Push a new view controller on the view controllers's stack.

       - parameter vc:       view controller to push.
       - parameter type:     transition animation type.
       - parameter duration: transition animation duration.
       */
      func push(viewController vc: UIViewController, transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
          self.addTransition(transitionType: type, duration: duration)
          self.pushViewController(vc, animated: false)
      }

    private func addTransition(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
          let transition = CATransition()
          transition.duration = duration
          transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
          transition.subtype = .fromRight
          transition.type = type
          self.view.layer.add(transition, forKey: nil)
      }

}

extension UIViewController {
    func removeChilde(viewController :  AnyClass) {
        for childVc in self.children {
            if childVc.isKind(of: viewController) {
                childVc.view.removeFromSuperview()
                childVc.removeFromParent()                
            }
        }
    }
    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
    
    /// Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    func showAlert(withMessage message: String?, title : String = "Demo", preferredStyle: UIAlertController.Style = .alert, withActions actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage( alertType: AlertType, message: String) {
        showAlert(title: alertType.rawValue, message: message)
    }
}


private var AssociatedObjectHandle: UInt8 = 0
extension UIViewController {

    var isAnimationRequired:Bool {
        get {
    return (objc_getAssociatedObject(self, &AssociatedObjectHandle) as? Bool) ?? true
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
extension UITabBarController {
    
    func addSubviewToLastTabItem(_ imageName: String) {
        if let lastTabBarButton = self.tabBar.subviews.last, let tabItemImageView = lastTabBarButton.subviews.first {
            if let accountTabBarItem = self.tabBar.items?.last {
                accountTabBarItem.selectedImage = nil
                accountTabBarItem.image = nil
            }
            
            let imgView = UIImageView()
            imgView.frame = tabItemImageView.frame
            
            imgView.layer.masksToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.sd_setImage(with: URL(string: imageName), completed: nil)
        }
    }
    func image(with image: UIImage, scaledTo newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
}
extension UIViewController {
func configureChildViewController(childController: UIViewController, onView: UIView?) {
    var holderView = self.view
    if let onView = onView {
        holderView = onView
    }
    childController.view.frame = self.view.bounds
    addChild(childController)
    holderView!.addSubview(childController.view)
    constrainViewEqual(holderView: holderView!, view: childController.view)
    childController.didMove(toParent: self)
    childController.willMove(toParent: self)
}


func constrainViewEqual(holderView: UIView, view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    //pin 100 points from the top of the super
    let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                    toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
    let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                       toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
    let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                     toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
    let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                      toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)

    holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
}}
