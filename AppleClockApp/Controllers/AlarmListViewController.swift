//
//  AlarmListViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit
import AVFoundation

class AlarmListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
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
            configureTableView()
            configureNavigation()
    }
    
    @IBAction func alarmEditButtonTapped(_ sender: Any) {
        isEditingMode.toggle()
        tableView.setEditing(!tableView.isEditing, animated: true)
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
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AlarmListCell", bundle: nil), forCellReuseIdentifier: "AlarmListCell")
        tableView.register(UINib(nibName: "AlarmListHeaderCell", bundle: nil), forCellReuseIdentifier: "AlarmListHeaderCell")
        tableView.backgroundColor = UIColor(name: .cellBackgroundColor)
    }
}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmListHeaderCell", for: indexPath) as! AlarmListHeaderCell
            cell.backgroundColor = UIColor(name: .cellBackgroundColor)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmListCell", for: indexPath) as! AlarmListCell
            let alarm = viewModel.alarmList[indexPath.row]
            cell.index = indexPath.row
            cell.delegate = self
            cell.alarmClockLabel.text = alarm.hour
            cell.alarmSwitch.isOn = alarm.isSwitchOn
            cell.alarmSubtitleLabel.textColor = UIColor(name: .titleColor)
            cell.backgroundColor = UIColor(name: .cellBackgroundColor)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.alarmList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 180
        } else {
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AlarmListHeaderCell") as? AlarmListHeaderCell else {
               return nil
           }
        header.backgroundColor = UIColor(name: .cellBackgroundColor)
           return header
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else {
                return
            }
            let addVC = viewModel.prepareAddAlarm()
            present(addVC, animated: true, completion: nil)
        }
    }


extension AlarmListViewController: AlarmSaveDelegate {
    func didUpdateAlarm(atIndex index: Int) {
        fatalError("didUpdateAlarm(atIndex:) must be implemented")

    }
    
    func alarmSaved(hour: String) {
        let currentDate = Date()
        viewModel.addAlarm(hour: hour, date: currentDate)
    }
}

extension AlarmListViewController: AlarmCellDelegate {
    func editingButtonTapped(index: Int, alarmTime: String?, isAlarmOn: Bool) {
           guard let alarmTime = alarmTime else {
               return
        }
    }
    
    func alarmSwitchValueChanged(isOn: Bool, index: Int) {
        viewModel.toggleSwitch(isOn: isOn, index: index)
    }
}

extension AlarmListViewController: AlarmListViewModelDelegate {
    func updateTableViewAtIndex(_ index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
}




