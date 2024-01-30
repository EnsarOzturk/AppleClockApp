//
//  UITabBarController+Extension.swift
//  AppleClockApp
//
//  Created by Ensar on 30.01.2024.
//

import UIKit

extension UITabBarController {
    
    func setupTabbar() {
            configureTabbar()
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
}
