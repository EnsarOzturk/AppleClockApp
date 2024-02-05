//
//  AlarmListViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit

class AlarmListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var editButton: UIBarButtonItem!
    
    var viewModel: AlarmListViewModel!
    var isEditingMode: Bool = false
    var selectedCell: [IndexPath] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel = AlarmListViewModel(delegate: self)
            view.backgroundColor = UIColor(name: .cellBackgroundColor)
            //navigationController?.setupNavigation()
            //tabBarController?.setupTabbar()
            configureTabbar()
            configureCollectionView()
            configureNavigation()
    }
    
    @IBAction func alarmEditButtonTapped(_ sender: Any) {
    }

    @IBAction func addAlarmToggleButtonTapped(_ sender: Any) {
        viewModel.delegate = self
        let addVC = viewModel.prepareAddAlarm()
        present(addVC, animated: false)
    }
    
    private func configureNavigation() {
        title = "Alarms"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor(name: .navigationBackgroundColor)
        navigationController?.navigationBar.tintColor = UIColor(name: .navigationButtonColor)
        navigationController?.navigationBar.barTintColor = UIColor(name: .navigationBackgroundColor)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(name: .titleColor)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(name: .titleColor)]
    }
    
    private func configureTabbar() {
        let selectedColor = UIColor(name: .tabbarSelectedColor)
        let unselectedColor = UIColor(name: .tabbarUnselectedColor)
        tabBarController?.tabBar.tintColor = UIColor(name: .tabbarSelectedColor)
        tabBarController?.tabBar.unselectedItemTintColor =  UIColor(name: .tabbarUnselectedColor)
        tabBarController?.tabBar.backgroundColor = UIColor(name: .tabbarBackgroundColor)
        tabBarController?.tabBar.barTintColor = UIColor(name: .tabbarBackgroundColor)
        
        if let items = tabBarController?.tabBar.items {
            for item in items {
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : unselectedColor], for: .normal)
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : selectedColor], for: .selected)
                item.selectedImage = UIImage(systemName: "alarm.fill")?.withTintColor(unselectedColor)
                item.image = UIImage(systemName: "alarm.fill")?.withTintColor(selectedColor)
            }
        }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlarmListCell", 
                                                      for: indexPath) as! AlarmListCell
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
            (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AlarmListHeaderCell", 
                                                             for: indexPath as IndexPath) as? AlarmListHeaderCell)!
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


    func editingButtonTapped(index: Int, alarmTime: String?, isAlarmOn: Bool) {
           guard let alarmTime = alarmTime else {
               return
        }
           let alarmVC = AlarmViewController()
           alarmVC.alarmTime = alarmTime
           alarmVC.isAlarmOn = isAlarmOn
           present(alarmVC, animated: true, completion: nil)
       }
    
    func alarmSwitchValueChanged(isOn: Bool, index: Int) {
        viewModel.toggleSwitch(isOn: isOn, index: index)
    }
}

extension AlarmListViewController: AlarmListViewModelDelegate {
    func updateCollectionView() {
        collectionView.reloadData()
    }
}




