//
//  HomeViewModel.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import Foundation
import ReactiveSwift

final class HomeViewModel {
    let currentDate: MutableProperty<Date> = .init(Date())
    let depatureTime: MutableProperty<Date?> = .init(nil)
    
    func startupdatingDate() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            self.currentDate.value = Date()
        }
    }
}
