//
//  AddAlarmViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 24.01.2024.
//

import UIKit

protocol AddAlarmDelagate: AnyObject {
    func alarmSaved(hour: String)
}

class AddAlarmViewController: UIViewController {
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addAlarmLabel: UILabel!
    weak var delegate: AddAlarmDelagate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDatePickerTextColor()
        
    }
    private func changeDatePickerTextColor() {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let hour = addAlarmLabel.text {
            delegate?.alarmSaved(hour: hour)
            self.dismiss(animated: true)
        }
    }
}
