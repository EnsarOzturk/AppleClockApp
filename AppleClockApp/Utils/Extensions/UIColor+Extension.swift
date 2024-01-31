//
//  UIColor+Extension.swift
//  AppleClockApp
//
//  Created by Ensar on 26.01.2024.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init(name: AssetsColor) {
        self.init(named: name.rawValue)!
    }
}

enum AssetsColor: String {
    case tabbarSelectedColor
    case tabbarUnselectedColor
    case navigationButtonColor
    case cellBackgroundColor
    case cellViewColor
    case navigationBackgroundColor
    case numberColor
    case setButtonColor
    case setButtonTitleColor
    case tabbarBackgroundColor
    case titleColor
    case roundButtonColor
    case roundButtonTitleColor
    case startButtonColor
    case startButtonTitleColor
    case stopWatchViewColor
}
