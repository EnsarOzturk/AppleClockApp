//
//  AlarmListViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 12.01.2024.
//

import UIKit

class AlarmListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var alarmList :[Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension AlarmListViewController: UICollectionViewDelegate {
    
}


