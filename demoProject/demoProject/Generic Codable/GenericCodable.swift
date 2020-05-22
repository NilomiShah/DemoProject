//
//  GenericCodable.swift
//  MVVM-Amit
//
//  Created by Amit on 18/04/19.
//  Copyright © 2019 MAC104. All rights reserved.
//

import Foundation

protocol GenericCodable {
    var value: Any { get }
    init<T>(_ value: T?)
}

extension GenericCodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self.value {
        case is Void:
            try container.encodeNil()
        case let bool as Bool:
            try container.encode(bool)
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let string as String:
            try container.encode(string)
        case let array as [Any?]:
            try container.encode(array.map { Generic($0) })
        case let dictionary as [String: Any?]:
            try container.encode(dictionary.mapValues { Generic($0) })
        default:
            let context = EncodingError.Context(codingPath: container.codingPath, debugDescription: "GenericCodable value cannot be encoded")
            throw EncodingError.invalidValue(self.value, context)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self.init(())
        } else if let bool = try? container.decode(Bool.self) {
            self.init(bool)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else if let double = try? container.decode(Double.self) {
            self.init(double)
        } else if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let array = try? container.decode([Generic].self) {
            self.init(array.map { $0.value })
        } else if let dictionary = try? container.decode([String: Generic].self) {
            self.init(dictionary.mapValues { $0.value })
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "GenericCodable value cannot be decoded")
        }
    }
}

extension GenericCodable {
    public init(nilLiteral: ()) {
        self.init(nil as Any?)
    }
    
    public init(booleanLiteral value: Bool) {
        self.init(value)
    }
    
    public init(integerLiteral value: Int) {
        self.init(value)
    }
    
    public init(floatLiteral value: Double) {
        self.init(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(arrayLiteral elements: Any...) {
        self.init(elements)
    }
    
    public init(dictionaryLiteral elements: (AnyHashable, Any)...) {
        self.init(Dictionary<AnyHashable, Any>(elements, uniquingKeysWith: { (first, _) in first }))
    }
}

