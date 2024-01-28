//
//  AlarmListHeaderCell.swift
//  AppleClockApp
//
//  Created by Ensar on 24.01.2024.
//

import UIKit

class AlarmListHeaderCell: UICollectionReusableView {
    @IBOutlet var setButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton.backgroundColor = UIColor(named: "setButton")
        setButton.layer.cornerRadius = 16.0
        setButton.titleLabel?.textColor = UIColor(named: "setButtonTitle")
      
    }
    
}
