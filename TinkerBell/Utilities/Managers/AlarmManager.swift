//
//  AlarmManager.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import Foundation
import ReactiveSwift
import UserNotifications

final class AlarmManager: NSObject {
    static let shared = AlarmManager()
    
    fileprivate(set) var depatureTime: MutableProperty<Date?> = .init(nil)
    fileprivate let center = UNUserNotificationCenter.current()
    
    fileprivate override init() {
        super.init()
        center.delegate = self
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            print("notification: \(granted)")
        }
    }
    
    func setAlarm(date: Date, alertMinutes: [Int]) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        depatureTime.value = date
        
        for alertMinute in alertMinutes {
            setNotification(date: date, beforeMinutes: alertMinute)
        }
    }
    
    func deleteAlarm() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        LocationChecker.shared.stopUptaing()
    }
    
    func sendCheerNotification() {
        let content = UNMutableNotificationContent()
        let message = L10n.cheerMessage
        content.body = message
        content.sound = UNNotificationSound(named: "good.m4a")
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest.init(identifier: "CheerNotification", content: content, trigger: trigger)
        center.add(request)
    }
}

private extension AlarmManager {
    func setNotification(date: Date, beforeMinutes: Int) {
        let content = UNMutableNotificationContent()
        let message = beforeMinutes == 0 ? L10n.depatureAlert : L10n.countdownAlert(beforeMinutes.description)
        content.body = message
        
        switch beforeMinutes {
        case 0:
            content.sound = UNNotificationSound(named: "0.m4a")
        case 3:
            content.sound = UNNotificationSound(named: "3.m4a")
            
        default:
            content.sound = UNNotificationSound.default()
        }
        
        let calendar = Calendar.current
        let comps = DateComponents(minute: -beforeMinutes)
        guard let triggerDate = calendar.date(byAdding: comps, to: date) else { return }
        
        let dateComponents = DateComponents(hour: calendar.component(.hour, from: triggerDate), minute:calendar.component(.minute, from: triggerDate))
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest.init(identifier: "NotificationBefore\(beforeMinutes)", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
        
        print("set notification at: \(trigger.nextTriggerDate()!)")
    }
}

extension AlarmManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceived")
        completionHandler()
        LocationChecker.shared.startUpdating()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        LocationChecker.shared.startUpdating()
    }

}
