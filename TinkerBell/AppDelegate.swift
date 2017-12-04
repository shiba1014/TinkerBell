//
//  AppDelegate.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        configureNavigationBar()
        configureStatusBar()
        requestAuthorization()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        return true
    }
}

private extension AppDelegate {
    func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = .themeColor(.main)
        UINavigationBar.appearance().tintColor = .fontColor(.primaryWhite)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.fontColor(.primaryWhite)]
        UINavigationBar.appearance().isTranslucent = false
    }
    
    func configureStatusBar() {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func requestAuthorization() {
        AlarmManager.shared.requestAuthorization()
        LocationChecker.shared.requestAuthorization()
    }
}
