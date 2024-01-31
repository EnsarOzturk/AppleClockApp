//
//  AlarmListCell.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit

protocol AlarmCellDelegate : AnyObject {
    func alarmSwitchValueChanged(isOn: Bool, index: Int)
    func trashButtonTapped(index: Int)
    func updateTrashButtonAppearance()
    func editingButtonTapped(index: Int, alarmTime: String?, isAlarmOn: Bool)
}

class AlarmListCell: UICollectionViewCell {
    @IBOutlet var alarmClockLabel: UILabel!
    @IBOutlet var alarmSwitch: UISwitch!
    @IBOutlet var view: UIView!
    @IBOutlet var trashButton: UIButton!
    @IBOutlet var editingButton: UIButton!
    
    weak var delegate : AlarmCellDelegate?
    var index: Int = 0
    
     var select: Bool = false {
          didSet {
              updateTrashButtonAppearance()
          }
      }

    override func layoutSubviews() {
        super.layoutSubviews()
        view.backgroundColor = UIColor(name: .cellViewColor)
        alarmClockLabel.textColor = UIColor(name: .titleColor)
        trashButton.layer.cornerRadius = 0.5 * trashButton.bounds.size.width
        trashButton.clipsToBounds = false
    }
    
      func updateTrashButtonAppearance() {
        let color = select ? UIColor.red : UIColor.black
           trashButton.tintColor = color
       }

    
    @IBAction func alarmSwitchClick(_ sender: UISwitch) {
        delegate?.alarmSwitchValueChanged(isOn: sender.isOn, index: index)
    }
    
    @IBAction func trashButtonTapped(_ sender: UIButton) {
        delegate?.trashButtonTapped(index: index)
        
    }
    
    @IBAction func editingButtonTapped(_ sender: UIButton) {
        delegate?.editingButtonTapped(index: index, alarmTime: alarmClockLabel.text, isAlarmOn: alarmSwitch.isOn)
    }
}
