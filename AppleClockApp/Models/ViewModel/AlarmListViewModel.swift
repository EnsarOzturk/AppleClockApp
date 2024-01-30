//
//  AlarmListViewModel.swift
//  AppleClockApp
//
//  Created by Ensar on 28.01.2024.
//

import Foundation

protocol AlarmListViewModelDelegate: AnyObject {
    func updateCollectionView()
}

class AlarmListViewModel {
    weak var delegate: AlarmListViewModelDelegate?
    var alarmList: [Alarm] = []
    var alarmKey = "NewAlarmList"

    init(delegate: AlarmListViewModelDelegate) {
        self.delegate = delegate
        getAlarmListFromUserDefaults()
    }
    
    func addAlarm(hour: String) {
           let alarm = Alarm(hour: hour, isSwitchOn: true)
           alarmList.append(alarm)
           delegate?.updateCollectionView()
           saveAlarmListToUserDefaults()
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
                delegate?.updateCollectionView()
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

