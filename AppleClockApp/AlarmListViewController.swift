//
//  AlarmListViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit

class AlarmListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var alarmList: [Alarm] = []
    var alarmKey = "NewAlarmList"
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "Alarms"
            self.navigationController?.navigationBar.prefersLargeTitles = true
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "AlarmListCell", bundle: nil), forCellWithReuseIdentifier: "AlarmListCell")
            collectionView.register(UINib(nibName: "AlarmListHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AlarmListHeaderCell")
            collectionView.backgroundColor = UIColor(named: "tabBarColor")
            view.backgroundColor = UIColor(named: "tabBarColor")
            navigationController?.navigationBar.backgroundColor = UIColor(named: "tabBarColor")
            navigationController?.navigationBar.tintColor = UIColor(named: "buttonColor")
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    
    @IBAction func alarmEditButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addAlarmToggleButtonTapped(_ sender: Any) {
        addAlarmFunc()
    }
    func addAlarmFunc() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(identifier: "AddAlarmViewController") as! AddAlarmViewController
        addVC.modalPresentationStyle = .popover
        addVC.modalTransitionStyle = .coverVertical
        addVC.delegate = self
        present(addVC, animated: true)
        
    }
}

extension AlarmListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlarmListCell", for: indexPath) as! AlarmListCell
        
        let alarm = alarmList[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        cell.alarmClockLabel.text = alarm.hour
        cell.alarmSwitch.isOn = alarm.isSwitchOn
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 110)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header: AlarmListHeaderCell!
        
        if kind == UICollectionView.elementKindSectionHeader {
            header =
            (collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                             withReuseIdentifier: "AlarmListHeaderCell", for: indexPath as IndexPath)
             as? AlarmListHeaderCell)!
            
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
        collectionView.reloadData()
    }
}

extension AlarmListViewController: AlarmCellDelegate {
    func alarmSwitchValueChanged(isOn: Bool, index: Int) {
        alarmList[index].isSwitchOn = isOn
    }
}

struct Alarm: Codable {
    var hour: String
    var isSwitchOn: Bool
}


