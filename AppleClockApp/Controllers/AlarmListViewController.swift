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
    @IBOutlet var deleteButton: UIBarButtonItem!
    
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
            deleteButton.isEnabled = false
            deleteButton.tintColor = .clear
            
    }
    
    @IBAction func alarmEditButtonTapped(_ sender: Any) {
        isEditingMode.toggle()
        collectionView.allowsMultipleSelection = isEditingMode
        updateTrashButtonAppearanceForSelectedCells()
        updateTrashButtonAppearance()
        deleteButton.isEnabled = isEditingMode
        
        if isEditingMode {
            deleteButton.tintColor = UIColor(name: .navigationButtonColor)
        } else {
            deleteButton.tintColor = .clear
        }
    }
    
    private func updateTrashButtonAppearanceForSelectedCells() {
        for indexPath in selectedCell {
            if let cell = collectionView.cellForItem(at: indexPath) as? AlarmListCell {
                cell.select = isEditingMode
                cell.updateTrashButtonAppearance()
            }
        }
    }
    
     func updateTrashButtonAppearance() {
        let trashButtonColor: UIColor = isEditingMode ? .red : .black

        for indexPath in collectionView.indexPathsForVisibleItems {
            if let cell = collectionView.cellForItem(at: indexPath) as? AlarmListCell {
                cell.trashButton.backgroundColor = trashButtonColor
            }
        }
    }
    
    
    private func deleteSelectedAlarms() {
        for indexPath in selectedCell {
            viewModel.deleteAlarm(at: indexPath.row)
        }
        selectedCell.removeAll()
        collectionView.reloadData()
        
        isEditingMode = false
        collectionView.allowsMultipleSelectionDuringEditing = false
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteSelectedAlarms()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlarmListCell", for: indexPath) as! AlarmListCell
        
        let alarm = viewModel.alarmList[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        cell.alarmClockLabel.text = alarm.hour
        cell.alarmSwitch.isOn = alarm.isSwitchOn
        let trashButtonColor: UIColor = isEditingMode ? .red: .black
        cell.trashButton.backgroundColor = trashButtonColor
    
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
    func trashButtonTapped(index: Int) {
        if isEditingMode {
                if let selectedIndexPath = collectionView.indexPathsForSelectedItems, selectedIndexPath.contains(IndexPath(row: index, section: 0)) {
                    selectedCell.removeAll { $0 == IndexPath(row: index, section: 0) }
                } else {
                    selectedCell.append(IndexPath(row: index, section: 0))
                }
                updateTrashButtonAppearanceForSelectedCells()
            }
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




