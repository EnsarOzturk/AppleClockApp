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
    
    func addAlarm(hour: String) {
           let alarm = Alarm(hour: hour, isSwitchOn: true)
           alarmList.append(alarm)
           viewModelDelegate?.updateTableView()
           saveAlarmListToUserDefaults()
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
        }
    }
    
    func saveAlarmListToUserDefaults() {
        let encoder = JSONEncoder()
        let alarmListData = try? encoder.encode(alarmList)
        let userDefaults = UserDefaults.standard
        userDefaults.set(alarmListData, forKey: alarmKey)
    }
}

