//
//  SetAlarmViewController.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

class SetDepatureTimeViewController: UIViewController {
    @IBOutlet fileprivate weak var departureTimeLabel: UILabel!
    @IBOutlet fileprivate weak var timePiker: UIDatePicker!
    @IBOutlet fileprivate weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension SetDepatureTimeViewController {
    func configure() {
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(asset: Asset.close), for: .normal)
        
        closeButton.reactive.controlEvents(.touchUpInside)
            .observeValues { [unowned self] _ in
                self.dismiss(animated: true, completion: nil)
        }
        
        let barButton = UIBarButtonItem(customView: closeButton)
        self.navigationItem.setLeftBarButton(barButton, animated: true)
        
        departureTimeLabel.textColor = .fontColor(.primaryPink)
        departureTimeLabel.numberOfLines = 0
        departureTimeLabel.text = L10n.setDepatureTime
    
        nextButton.reactive.controlEvents(.touchUpInside).observe { [weak self] _ in
            guard let `self` = self else { return }
            let depatureTime = self.timePiker.date
            let setCountDownVC = SetCountDownViewController.instantiate(depatureTime: depatureTime)
            self.navigationController?.pushViewController(setCountDownVC, animated: true)
        }
    }
}
