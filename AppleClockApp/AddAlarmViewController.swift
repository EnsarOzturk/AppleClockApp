//
//  AddAlarmViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 24.01.2024.
//

import UIKit

protocol AlarmSaveDelagate: AnyObject {
    func alarmSaved(hour: String)
}

class AddAlarmViewController: UIViewController {
    weak var delegate : AlarmSaveDelagate?
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addAlarmLabel: UILabel!
    
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
    
    @IBAction func datePickerValueChange(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .short
        dateFormater.dateFormat = "HH:mm"
        addAlarmLabel.text = dateFormater.string(from: datePicker.date)
    }
}
