//
//  AlarmListViewModel.swift
//  AppleClockApp
//
//  Created by Ensar on 28.01.2024.
//

import Foundation
import UIKit

protocol AlarmListViewModelDelegate: AnyObject {
    func updateTableView()
    func updateTableViewAtIndex(_ index: Int)
}

class AlarmListViewModel {
    weak var viewModelDelegate: AlarmListViewModelDelegate?
    weak var delegate : AlarmSaveDelegate?
    var alarmList: [Alarm] = []
    var alarmKey = "NewAlarmList"

    init(delegate: AlarmListViewModelDelegate) {
        self.viewModelDelegate = delegate
        getAlarmListFromUserDefaults()
    }
    
    func addAlarm(hour: String, date: Date) {
        let alarm = Alarm(hour: hour, isSwitchOn: true, date: date)
           alarmList.append(alarm)
           print("Alarm added:", alarmList) 
           saveAlarmListToUserDefaults()
           viewModelDelegate?.updateTableView()
       }
    
    func prepareAddAlarm() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(identifier: "AddAlarmViewController") as! AddAlarmViewController
        addVC.modalPresentationStyle = .popover
        addVC.modalTransitionStyle = .coverVertical
        addVC.delegate = delegate
        return addVC
    }
    
    func toggleSwitch(isOn: Bool, index: Int) {
           alarmList[index].isSwitchOn = isOn
           saveAlarmListToUserDefaults()
    }
    
    func deleteAlarm(at index: Int) {
        alarmList.remove(at: index)
        saveAlarmListToUserDefaults()
        viewModelDelegate?.updateTableView()
    }
    
    func getAlarmListFromUserDefaults() {
        if let alarmListData = UserDefaults.standard.data(forKey: alarmKey) {
            do {
                let decoder = JSONDecoder()
                let alarmList = try decoder.decode([Alarm].self, from: alarmListData)
                self.alarmList = alarmList
                viewModelDelegate?.updateTableView()
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        } else {
            print("No Alarm List found in UserDefaults")
        }
    }
    
    func saveAlarmListToUserDefaults() {
        let encoder = JSONEncoder()
        do {
            let alarmListData = try encoder.encode(alarmList)
            let userDefaults = UserDefaults.standard
            userDefaults.set(alarmListData, forKey: alarmKey)
        } catch {
            print("Unable to Encode Alarm List: \(error)")
        }
    }
}

