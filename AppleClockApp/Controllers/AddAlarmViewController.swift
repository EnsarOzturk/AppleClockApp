//
//  AddAlarmViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 24.01.2024.
//

import UIKit

protocol AlarmSaveDelegate: AnyObject {
    func alarmSaved(hour: String)
    func didUpdateAlarm(atIndex index: Int)
}

class AddAlarmViewController: UIViewController {
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addAlarmLabel: UILabel!
    var delegate : AlarmSaveDelegate!
    var viewModel: AddAlarmViewModelProtocol!
    
    var updateIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddAlarmViewModel(datePicker: datePicker)
        viewModel.setDatePicker(datePicker)
        viewModel.changeDatePickerTextColor(datePicker: datePicker)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        viewModel.cancelButtonTapped(alarmListViewController: self)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
//        viewModel.saveButtonTapped(hour: addAlarmLabel.text ?? "", delegate: delegate)
//        self.dismiss(animated: true, completion: nil)
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm" // Saat formatını ayarlayın
           let selectedTime = dateFormatter.string(from: datePicker.date)
           
           viewModel.saveButtonTapped(hour: selectedTime, delegate: delegate)
           self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerValueChange(_ sender: UIDatePicker) {
        viewModel.datePickerValueChanged(datePicker: sender, label: addAlarmLabel)
    }
}
