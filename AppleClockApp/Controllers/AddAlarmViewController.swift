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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddAlarmViewModel(datePicker: datePicker)
        viewModel.setDatePicker(datePicker)
        viewModel.changeDatePickerTextColor(datePicker: datePicker)
        updateAddAlarmLabel()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        viewModel.cancelButtonTapped(alarmListViewController: self)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let selectedTimeString = getSelectedTimeString()
            viewModel.saveButtonTapped(hour: selectedTimeString, delegate: delegate)
            dismiss(animated: true, completion: nil)
    }
    
    private func updateAddAlarmLabel() {
         let selectedTimeString = getSelectedTimeString()
         addAlarmLabel.text = selectedTimeString
     }
    
    private func getSelectedTimeString() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm"
           return dateFormatter.string(from: datePicker.date)
       }
    
    @IBAction func datePickerValueChange(_ sender: UIDatePicker) {
        updateAddAlarmLabel()
    }
}
