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
    
    var viewModel = ClockViewModel()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "Alarm"
            self.navigationController?.navigationBar.prefersLargeTitles = true
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

    extension AlarmListViewController: AlarmSaveDelagate {
        func alarmSaved(hour: String) {
            viewModel.addAlarm(hour: hour, isSwitchOn: true)
            collectionView.reloadData()
        }
    }

    extension AlarmListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.numberOfAlarms
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            // TODO: Alarm cell configuration using viewModel
            return UICollectionViewCell()
        }
        
        // Diğer UICollectionViewDelegate ve UICollectionViewDataSource metodları...

        // TODO: Diğer metodlar ve extension'lar...
    }



