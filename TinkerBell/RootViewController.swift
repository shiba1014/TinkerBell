//
//  ViewController.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showHomeViewController()
    }
}

private extension RootViewController {
    func showHomeViewController() {
        let homeVC = HomeViewController.instantiate()
        addChild(homeVC, toContainerView: view)
    }
}
