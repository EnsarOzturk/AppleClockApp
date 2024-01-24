//
//  ClockViewModel.swift
//  AppleClockApp
//
//  Created by Ensar on 24.01.2024.
//

import Foundation

class ClockViewModel {
    private var alarmList: [AlarmModel] = []
    
    var numberOfAlarms: Int {
          return alarmList.count
      }
      
      func getAlarm(at index: Int) -> AlarmModel {
          return alarmList[index]
      }
      
      func addAlarm(hour: String, isSwitchOn: Bool) {
          let newAlarm = AlarmModel(hour: hour, isSwitchOn: isSwitchOn)
          alarmList.append(newAlarm)
          saveAlarmListToUserDefaults()
      }
      
      func updateAlarmSwitchState(isOn: Bool, at index: Int) {
          alarmList[index].isSwitchOn = isOn
          saveAlarmListToUserDefaults()
      }

      private func saveAlarmListToUserDefaults() {
          let encoder = JSONEncoder()
          if let alarmListData = try? encoder.encode(alarmList) {
              let userDefaults = UserDefaults.standard
              userDefaults.set(alarmListData, forKey: "NewAlarmList")
          }
      }
  }

