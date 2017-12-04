//
//  HomeViewController.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit
import ReactiveSwift

class HomeViewController: UIViewController {
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet fileprivate weak var depatureTimeLabel: UILabel!
    @IBOutlet fileprivate weak var setAlarmButton: UIButton!
    @IBOutlet fileprivate weak var deleteAlarmButton: UIButton!
    
    fileprivate var vm = HomeViewModel()
    fileprivate var now = Date()
    fileprivate let alarmManager = AlarmManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension HomeViewController {
    func configure() {
        dateLabel.textColor = .fontColor(.primaryWhite)
        timeLabel.textColor = .fontColor(.primaryWhite)
        depatureTimeLabel.textColor = .fontColor(.primaryWhite)
        setAlarmButton.tintColor = .fontColor(.primaryWhite)
        
        depatureTimeLabel.adjustsFontSizeToFitWidth = true
        
        alarmManager.depatureTime.producer.startWithValues { [unowned self] date in
            self.depatureTimeLabel.text = date?.toTimeFormat() ?? L10n.noDepatureTime
        }
        
        vm.startupdatingDate()
        vm.currentDate.producer.startWithValues { [unowned self] date in
            self.dateLabel.text = date.toDateFormat()
            self.timeLabel.text = date.toTimeFormat()
        }
        
        setAlarmButton.reactive.controlEvents(.touchUpInside)
            .observe { [weak self] _ in
                guard let `self` = self else { return }
                let setAlarmVC = SetDepatureTimeViewController.instantiate().navigate
                self.present(setAlarmVC, animated: true)
        }
        
        deleteAlarmButton.reactive.controlEvents(.touchUpInside)
            .observe { [weak self] _ in
                guard let `self` = self else { return }
                if self.alarmManager.depatureTime.value == nil {
                    let alert = UIAlertController(title: nil, message: L10n.notDepatureTimeAlert, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: L10n.uhOh, style: .default, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true)
                } else {
                    self.showDeleteAlert()
                }
        }
    }
    
    func showDeleteAlert() {
        let alert = UIAlertController(title: nil, message: L10n.deleteAlarmAlert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.delete, style: .destructive, handler: { _ in
            AlarmManager.shared.deleteAlarm()
            self.depatureTimeLabel.text = L10n.noDepatureTime
        })
        let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
