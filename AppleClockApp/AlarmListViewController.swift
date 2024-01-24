//
//  AlarmListViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit

protocol AlarmSaveDelagate: AnyObject {
    func alarmSaved(hour: String)
}

class AlarmListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var AddAlarmToggleButtonTapped: UIBarButtonItem!
    @IBOutlet var AlarmEditButtonTapped: UIBarButtonItem!
    
    var viewModel = ClockViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Alarm"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(UINib(nibName: "AlarmListHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AlarmListHeaderCell")
    }
}

extension AlarmListViewController: AlarmSaveDelagate {
        func alarmSaved(hour: String) {
            viewModel.addAlarm(hour: hour, isSwitchOn: true)
            collectionView.reloadData()
        }
    }



