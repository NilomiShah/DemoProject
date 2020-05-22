//
//  Generic.swift
//  MVVM-Amit
//
//  Created by Amit on 18/04/19.
//  Copyright © 2019 MAC104. All rights reserved.
//

import Foundation

struct Generic: Codable {
    let value: Any
    
    public init<T>(_ value: T?) {
        self.value = value ?? ()
    }
}

extension Generic: GenericCodable, ExpressibleByNilLiteral, ExpressibleByBooleanLiteral, ExpressibleByIntegerLiteral, ExpressibleByStringLiteral, ExpressibleByFloatLiteral, ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral {}

extension Generic {
    
    var boolValue: Bool {
        switch value {
        case let bool as Bool:
            return bool
        case let string as String:
            let lowerString = string.lowercased()
            if ["true", "t", "yes", "y", "1"].contains(lowerString) {
                return true
            } else if ["false", "f", "no", "n", "0"].contains(lowerString) {
                return false
            }
            return false
        case let double as Double:
            return double != 0.0
        case let int as Int:
            return int != 0
        case _ as [Any]:
            return false
        case _ as [String: Any]:
            return false
        default:
            return false
        }
    }
    
    var stringValue: String {
        
        switch value {
        case let bool as Bool:
            return bool ? "true" : "false"
        case let string as String:
            return string
        case let double as Double:
            return String(double)
        case let int as Int:
            return String(int)
        case _ as [Any]:
            return ""
        case _ as [String: Any]:
            return ""
        default:
            return ""
        }
    }
    
    var intValue: Int {
        
        switch value {
        case let bool as Bool:
            return bool ? 1 : 0
        case let string as String:
            return Int(string) ?? 0
        case let double as Double:
            return Int(double)
        case let int as Int:
            return int
        case _ as [Any]:
            return 0
        case _ as [String: Any]:
            return 0
        default:
            return 0
        }
    }
    
    var doubleValue: Double {
        
        switch value {
        case let bool as Bool:
            return bool ? 1.0 : 0.0
        case let string as String:
            return Double(string) ?? 0
        case let double as Double:
            return double
        case let int as Int:
            return Double(int)
        case _ as [Any]:
            return 0.0
        case _ as [String: Any]:
            return 0.0
        default:
            return 0.0
        }
    }
    
    var dictionaryValue: [String: Any] {
        
        switch value {
        case let dict as [String: Any]:
            return dict
        default:
            return [:]
        }
    }
    
    var arrayValue: [Any] {
        
        switch value {
        case let array as [Any]:
            return array
        default:
            return []
        }
    }
}

extension Generic: Equatable {
    public static func ==(lhs: Generic, rhs: Generic) -> Bool {
        switch (lhs.value, rhs.value) {
        case is (Void, Void):
            return true
        case let (lhs as Bool, rhs as Bool):
            return lhs == rhs
        case let (lhs as Int, rhs as Int):
            return lhs == rhs
        case let (lhs as Double, rhs as Double):
            return lhs == rhs
        case let (lhs as String, rhs as String):
            return lhs == rhs
        case (let lhs as [String: Generic], let rhs as [String: Generic]):
            return lhs == rhs
        case (let lhs as [Generic], let rhs as [Generic]):
            return lhs == rhs
        default:
            return false
        }
    }
}
