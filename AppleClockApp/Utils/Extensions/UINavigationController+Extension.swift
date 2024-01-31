//
//  UINavigation+Extension.swift
//  AppleClockApp
//
//  Created by Ensar on 29.01.2024.
//

import UIKit

extension UINavigationController {
    
    func setupNavigation() {
            configureNavigation()
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
}

