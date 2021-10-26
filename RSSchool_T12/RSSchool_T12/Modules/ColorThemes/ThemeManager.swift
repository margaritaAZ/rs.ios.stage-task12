//
//  ThemeManager.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 27.09.21.
//

import Foundation
import UIKit

enum Theme: Int, CaseIterable {
    case gold, pink, violetRose, green, blueViolet
    
    var backgroundImage: UIImage {
        switch self {
        case .gold:
            return UIImage(named: "1") ?? UIImage()
        case .pink:
            return UIImage(named: "2") ?? UIImage()
        case .violetRose:
            return UIImage(named: "3") ?? UIImage()
        case .green:
            return UIImage(named: "4") ?? UIImage()
        case .blueViolet:
            return UIImage(named: "5") ?? UIImage()
        }
    }
}


class ThemeManager {
    static let defaultTheme: Theme = .gold
    
    func getBackgroundImage(theme: Theme) -> UIImage {
        theme.backgroundImage
    }
}
