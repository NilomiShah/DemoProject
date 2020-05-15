
import Foundation
import UIKit

extension UIFont {

    struct Calibre {
        static let regular = { (size: CGFloat) -> UIFont in
            return UIFont(name: "Calibre-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        static let regularItalic = { (size: CGFloat) -> UIFont in
            return UIFont(name: "Calibre-RegularItalic", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        static let medium = { (size: CGFloat) -> UIFont in
            return UIFont(name: "Calibre-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        static let semibold = { (size: CGFloat) -> UIFont in
            return UIFont(name: "Calibre-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        static let black = { (size: CGFloat) -> UIFont in
            return UIFont(name: "Calibre-Black", size: size) ?? UIFont.systemFont(ofSize: size)
        }

        static let bold = { (size: CGFloat) -> UIFont in
            return UIFont(name: "Calibre-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        }

    }
}
