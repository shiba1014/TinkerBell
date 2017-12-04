//
//  StoryboardExt.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

// This implementation should be moved to UIStoryboard extension after applying Swift 2.0
struct Storyboard {
    static var nameConverter: (String) -> String = {
        $0.replacingOccurrences(of: "ViewController", with: String.empty, options: [], range: nil)
    }
    
    static func instantiate<T: UIViewController>(_ type: T.Type) -> T {
        let cname = String(classNameOf: type)
        let storyboardName = nameConverter(cname)
        
        let sb = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController() as! T    // swiftlint:disable:this force_cast
        return vc
    }
}

