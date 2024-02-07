//
//  AlarmListHeaderCell.swift
//  AppleClockApp
//
//  Created by Ensar on 5.02.2024.
//

import UIKit

class AlarmListHeaderCell: UITableViewCell {
    @IBOutlet var setButton: UIButton!
    @IBOutlet var viewView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton.backgroundColor = UIColor(name: .setButtonColor)
        setButton.layer.cornerRadius = 16.0
        setButton.titleLabel?.textColor = UIColor(name: .setButtonTitleColor)
        viewView.backgroundColor = UIColor(name: .cellViewColor)
    }
}
