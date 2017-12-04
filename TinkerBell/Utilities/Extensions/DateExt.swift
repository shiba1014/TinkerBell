//
//  DateExt.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import Foundation

public extension Date {
    func toDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd(E)"
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: self)
    }
    
    func toTimeFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}

