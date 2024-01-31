//
//  AddAlarmViewModel.swift
//  AppleClockApp
//
//  Created by Ensar on 28.01.2024.
//

import Foundation
import UIKit

protocol AddAlarmViewModelProtocol {
    var selectedHour: String { get }
    func changeDatePickerTextColor(datePicker: UIDatePicker)
    func setDatePicker(_ datePicker: UIDatePicker)
    func datePickerValueChanged(datePicker: UIDatePicker, label: UILabel)
    func saveButtonTapped(hour: String, delegate: AlarmSaveDelegate)
    func cancelButtonTapped(alarmListViewController: UIViewController)
}

class AddAlarmViewModel: AddAlarmViewModelProtocol {

    var selectedHour: String = ""
    var datePicker:  UIDatePicker?
    
    init(datePicker:  UIDatePicker?) {
        self.datePicker =  datePicker
    }
    
    func changeDatePickerTextColor(datePicker: UIDatePicker) {
          datePicker.setValue(UIColor(name: .titleColor), forKeyPath: "textColor")
      }
    
    func saveButtonTapped(hour: String, delegate: AlarmSaveDelegate) {
          delegate.alarmSaved(hour: hour)
       }
    
    func cancelButtonTapped(alarmListViewController: UIViewController) {
        alarmListViewController.dismiss(animated: true, completion: nil)
    }
    
    func datePickerValueChanged(datePicker: UIDatePicker, label: UILabel) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.dateFormat = "HH:mm"
        do {
            selectedHour = dateFormatter.string(from: datePicker.date)
            label.text = selectedHour
        } catch {
            print("Date formatting error: \(error.localizedDescription)")
        }
    }
    
    func setDatePicker(_ datePicker: UIDatePicker) {
        self.datePicker = datePicker
    }
}
