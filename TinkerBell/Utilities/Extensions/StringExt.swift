//
//  StringExt.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import Foundation

public extension String {
    static var empty: String {
        return ""
    }
    
    static var comma: String {
        return ","
    }
    
    static var colon: String {
        return ":"
    }
    
    static var percent: String {
        return "%"
    }
    
    static var emColon: String {
        return "\u{FF1A}"
    }
    
    static var space: String {
        return "\u{2003}"   // 1 em space
    }
    
    static var halfSpace: String {
        return "\u{2002}"
    }
    
    static var quarterSpace: String {
        return "\u{2005}"
    }
    
    static var noWidthSpace: String {
        return "\u{FEFF}"
    }
    
    static var lineBreak: String {
        return "\n"
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var base64: String {
        let data = self.data(using: .utf8)
        return data!.base64EncodedString(options: [])
    }
    
    var urlEncoded: String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        
        return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet) ?? self
    }
    
    init(classNameOf: AnyClass) {
        self = NSStringFromClass(classNameOf).components(separatedBy: ".").last!
    }
    
    func regex(_ options: NSRegularExpression.Options = []) -> NSRegularExpression? {
        return try? NSRegularExpression(pattern: self, options: options)
    }
    
    func split(_ separator: String) -> [String] {
        return characters.split(whereSeparator: separator.characters.contains).map(String.init)
    }
    
    //    func removeLineBreaks() -> String {
    //        return replacingOccurrences(of: "\n|\r", with: .empty, options: .regularExpression)
    //    }
    //
    //    func removeSpaces() -> String {
    //        return replacingOccurrences(of: " ", with: .empty, options: .regularExpression)
    //    }
    //
    //    func removeSpaceAndLineBreaks() -> String {
    //        return removeLineBreaks().removeSpaces()
    //    }
    
//    func truncate(_ length: Int, trailing: String = .empty) -> String {
//        if characters.count > length {
//            return substring(to: characters.index(startIndex, offsetBy: length)) + trailing
//        } else {
//            return self
//        }
//    }
}

// MARK: Static methods

public extension String {
    static func base64(_ data: Data) -> String {
        return data.base64EncodedString(options: [])
    }
    
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: .empty)
    }
}

