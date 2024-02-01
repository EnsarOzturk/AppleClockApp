//
//  StopWatchListCell.swift
//  AppleClockApp
//
//  Created by Ensar on 31.01.2024.
//

import UIKit

class StopWatchListCell: UICollectionViewCell {
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var view: UIView!
    
    func updateRoundLabel(with time: String) {
         roundLabel.text = time
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundLabel.textColor = UIColor(name: .titleColor)
        view.backgroundColor = UIColor(name: .cellViewColor)
        layer.backgroundColor = UIColor(name: .cellBackgroundColor).cgColor
    }
}
