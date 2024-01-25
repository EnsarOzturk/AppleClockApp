//
//  AlarmListViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit

class AlarmListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    let alarmlist: [Alarm] = []
    var alarmKey = "NewAlarmList"
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "Alarm"
            self.navigationController?.navigationBar.prefersLargeTitles = true
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "AlarmListHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AlarmListHeaderCell")

        }
    
    @IBAction func alarmEditButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addAlarmToggleButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let addVC = storyboard.instantiateViewController(identifier: "AddAlarmViewController") as! AddAlarmViewController
               addVC.modalPresentationStyle = .fullScreen
               present(addVC, animated: true, completion: nil)
    }
}

extension AlarmListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AlarmCell
        
        let alarm = alarmList[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        cell.alarmLabel.text = alarm.hour
        cell.alarmSwitch.isOn = alarm.isSwitchOn
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 110)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header: HeaderCell!
        
        if kind == UICollectionView.elementKindSectionHeader {
            header =
            (collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                             withReuseIdentifier: "headerCell", for: indexPath as IndexPath)
             as? HeaderCell)!
            
            return header
        }else {
            return UICollectionReusableView()
        }
    }
}

extension AlarmListViewController: AlarmSaveDelagate {
    func alarmSaved(hour: String) {
        let alarm = Alarm(hour: hour, isSwitchOn: true)
        alarmList.append(alarm)
        
        alarmCollectionView.reloadData()
        
        saveAlarmListToUserDefaults()
    }
}

extension AlarmListViewController: AlarmCellDelegate {
    func alarmSwitchValueChanged(isOn: Bool, index: Int) {
        
        alarmList[index].isSwitchOn = isOn
        saveAlarmListToUserDefaults()
    }
}

struct Alarm: Codable {
    var hour: String
    var isSwitchOn: Bool
}


