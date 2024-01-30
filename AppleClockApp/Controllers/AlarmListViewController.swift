//
//  AlarmListViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit

class AlarmListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var viewModel: AlarmListViewModel!

        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel = AlarmListViewModel(delegate: self)
            view.backgroundColor = UIColor(name: .cellBackgroundColor)
            navigationController?.setupNavigation()
            tabBarController?.setupTabbar()
            configureCollectionView()
    }
    
    @IBAction func alarmEditButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func addAlarmToggleButtonTapped(_ sender: Any) {
        viewModel.delegate = self
        let addVC = viewModel.prepareAddAlarm()
        present(addVC, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AlarmListCell", bundle: nil), forCellWithReuseIdentifier: "AlarmListCell")
        collectionView.register(UINib(nibName: "AlarmListHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AlarmListHeaderCell")
        collectionView.backgroundColor = UIColor(named: "tabBarColor")
    }
}

extension AlarmListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.alarmList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlarmListCell", for: indexPath) as! AlarmListCell
        let alarm = viewModel.alarmList[indexPath.row]
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
            (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AlarmListHeaderCell", for: indexPath as IndexPath)
             as? AlarmListHeaderCell)!
            
            return header
        }else {
            return UICollectionReusableView()
        }
    }
}

extension AlarmListViewController: AlarmSaveDelegate {
    func alarmSaved(hour: String) {
        viewModel.addAlarm(hour: hour)
    }
}

extension AlarmListViewController: AlarmCellDelegate {
    func alarmSwitchValueChanged(isOn: Bool, index: Int) {
        viewModel.toggleSwitch(isOn: isOn, index: index)
    }
}

extension AlarmListViewController: AlarmListViewModelDelegate {
    func updateCollectionView() {
        collectionView.reloadData()
    }
}




