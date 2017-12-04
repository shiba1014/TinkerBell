//
//  UIViewControllerExt.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

extension UIViewController {
    static func instantiate() -> Self {
        return Storyboard.instantiate(self)
    }
}

public extension Reactive where Base: UIViewController {
    var viewWillAppear: Signal<(), NoError> {
        return base.reactive.signal(for: #selector(Base.viewWillAppear(_:))).map{ _ in}
    }
    
    var viewWillDisappear: Signal<(), NoError> {
        return base.reactive.signal(for: #selector(Base.viewWillDisappear(_:))).map{ _ in}
    }
    
    var viewDidAppear: Signal<(), NoError> {
        return base.reactive.signal(for: #selector(Base.viewDidAppear(_:))).map{ _ in}
    }
    
    var viewDidLayoutSubviews: Signal<(), NoError> {
        return base.reactive.signal(for: #selector(Base.viewDidLayoutSubviews)).map{ _ in}
    }
}

public extension UIViewController {
    func addChild(_ vc: UIViewController, toContainerView containerView: UIView, withConstraints: Bool = true) {
        addChildViewController(vc)
        containerView.addSubview(vc.view)
        
        vc.didMove(toParentViewController: self)
    }
    
    func removeFromParent(_ vc: UIViewController) {
        willMove(toParentViewController: vc)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
    func popToRootIfNotOnTop(animated: Bool, onTopHandler: () -> Void) {
        guard let navigationController = navigationController, navigationController.topViewController != self else {
            onTopHandler()
            return
        }
        navigationController.popToRootViewController(animated: animated)
    }
    
    var forefrontViewController: UIViewController {
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.forefrontViewController ?? self
        }
        return presentedViewController?.forefrontViewController ?? self
    }
    
    var navigate: UINavigationController {
        return navigationController ?? UINavigationController(rootViewController: self)
    }
}
