//
//  AlarmListViewModel.swift
//  AppleClockApp
//
//  Created by Ensar on 28.01.2024.
//

import Foundation

class AlarmListViewModel {
    var alarmList: [Alarm] = []
    var alarmKey = "NewAlarmList"
    
    func getAlarmListFromUserDefault() {
        if let alarmListData = UserDefaults.standard.data(forKey: alarmKey) {
            do {
                    let decoder = JSONDecoder()

                    let alarmList = try decoder.decode([Alarm].self, from: alarmListData)
                self.alarmList = alarmList
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
