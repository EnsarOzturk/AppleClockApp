//
//  AlarmListCell.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit

protocol AlarmCellDelegate : AnyObject {
    func alarmSwitchValueChanged(isOn: Bool, index: Int)
}

class AlarmListCell: UICollectionViewCell {
    @IBOutlet var alarmClockLabel: UILabel!
    @IBOutlet var alarmSwitch: UISwitch!
    @IBOutlet var view: UIView!
    
    weak var delegate : AlarmCellDelegate?
    var index: Int = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.backgroundColor = UIColor(name: .cellViewColor)
        alarmClockLabel.textColor = UIColor(name: .titleColor)
    }

    @IBAction func alarmSwitchClick(_ sender: UISwitch) {
        delegate?.alarmSwitchValueChanged(isOn: sender.isOn, index: index)
    }
}
