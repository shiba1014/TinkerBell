//
//  SetCountDownViewController.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/02.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

class SetCountDownViewController: UIViewController {
    @IBOutlet fileprivate weak var departureTimeLabel: UILabel!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var saveButton: UIButton!
    
    fileprivate var depatureTime: Date!
    fileprivate let countDownMinArray = [60, 45, 30, 20, 10, 5, 3]
    fileprivate var alarmMinutes: [Int] = [60, 45, 30, 20, 10, 5, 3, 0]
    
    static func instantiate(depatureTime: Date) -> SetCountDownViewController {
        let vc = SetCountDownViewController.instantiate()
        vc.depatureTime = depatureTime
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension SetCountDownViewController {
    func configure() {
        departureTimeLabel.textColor = .fontColor(.primaryPink)
        departureTimeLabel.text = "\(L10n.departureTime)\n\(depatureTime.toTimeFormat())"
        departureTimeLabel.numberOfLines = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        saveButton.reactive.controlEvents(.touchUpInside)
            .observe { [weak self] _ in
                guard let `self` = self else { return }
                AlarmManager.shared.setAlarm(date: self.depatureTime, alertMinutes: self.alarmMinutes)
                self.dismiss(animated: true)
        }
    }
}

extension SetCountDownViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countDownMinArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = L10n.beforeMinutes(countDownMinArray[indexPath.item].description)
        let sw = UISwitch()
        sw.reactive.controlEvents(.valueChanged)
            .observe { [weak self] signal in
                guard let `self` = self,
                    let sw = signal.value else { return }
                if sw.isOn {
                    self.alarmMinutes.append(self.countDownMinArray[indexPath.item])
                } else {
                    guard let index = self.countDownMinArray.index(of: self.countDownMinArray[indexPath.item]) else { return }
                    self.alarmMinutes.remove(at: index)
                }
        }
        sw.isOn = true
        sw.onTintColor = .themeColor(.main)
        cell.accessoryView = sw
        return cell
    }
}

extension SetCountDownViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(countDownMinArray.count)
    }
}
