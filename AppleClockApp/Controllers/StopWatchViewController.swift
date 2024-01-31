//
//  StopWatchViewController.swift
//  AppleClockApp
//
//  Created by Ensar on 26.01.2024.
//

import UIKit

class StopWatchViewController: UIViewController {
    @IBOutlet var stopWatchLabel: UILabel!
    @IBOutlet var roundButton: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopWatchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(name: .cellBackgroundColor)
        roundButton.layer.cornerRadius = 0.5 * roundButton.bounds.size.width
        roundButton.backgroundColor = UIColor(name: .roundButtonColor)
        roundButton.titleLabel?.textColor = UIColor(name: .roundButtonTitleColor)
        startButton.backgroundColor = UIColor(name: .startButtonColor)
        startButton.titleLabel?.textColor = UIColor(name: .startButtonTitleColor)
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
        stopWatchLabel.textColor = UIColor(name: .titleColor)
        stopWatchView.backgroundColor = UIColor(name: .stopWatchViewColor)
    }
}
