//
//  UIColorExt.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//
import UIKit

public protocol ColorType {
    var rgba: Int64 { get }
}

public extension ColorType where Self: RawRepresentable, Self.RawValue == Int64 {
    var rgba: Int64 {
        return rawValue
    }
}

public extension UIColor {
    convenience init(type: ColorType) {
        self.init(rgba: type.rgba)
    }
    
    convenience init(rgba: Int64) {
        let red = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgba & 0xFF0000) >> 16) / 255.0
        let blue = CGFloat((rgba & 0xFF00) >> 8) / 255.0
        let alpha = CGFloat(rgba & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    enum Theme: Int64, ColorType {
        case base = 0xFCF7F5FF
        case main = 0xF75763FF
        case accent = 0xD9402BFF
    }
    
    enum Font: Int64, ColorType {
        case primaryWhite = 0xFCF7F5FF
        case primaryPink = 0xF75763FF
        case secondaryGray = 0x757575FF
        case tertiaryGray = 0x8C8C8CFF
    }
    
    enum Sns: Int64, ColorType {
        case twitter = 0x4099FFFF
        case facebook = 0x3B5998FF
        case line = 0x00BB00FF
    }
    
    static func themeColor(_ type: Theme) -> UIColor {
        return .init(type: type)
    }
    
    static func snsColor(_ type: Sns) -> UIColor {
        return .init(type: type)
    }
    
    static func fontColor(_ type: Font) -> UIColor {
        return .init(type: type)
    }
    
    func alphaColor(_ alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
}

