//
//  Helpers.swift
//  Helpers
//
//  Created by Маргарита Жучик on 23.09.21.
//

import Foundation
import UIKit

extension UIFont {
    enum Style: String {
        case medium, regular, semiBold, bold
    }
    
    static func montserrat(_ type: Style, _ size: CGFloat) -> UIFont{
        UIFont.init(name: "Montserrat-\(type.rawValue.capitalized)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIColor {
    static let amaranthRed: UIColor = UIColor(named: "Amaranth Red")!
    static let babyPowder: UIColor = UIColor(named: "Baby Powder")!
    static let celadon: UIColor = UIColor(named: "Celadon")!
    static let darkPurple: UIColor = UIColor(named: "Dark Purple")!
    static let deepSaffron: UIColor = UIColor(named: "Deep Saffron")!
    static let greenBlueCrayola: UIColor = UIColor(named: "Green Blue Crayola")!
    static let honeydew: UIColor = UIColor(named: "Honeydew")!
    static let lightCyan: UIColor = UIColor(named: "Light Cyan")!
    static let pink: UIColor = UIColor(named: "Pink")!
    static let rickBlack: UIColor = UIColor(named: "Rick Black FOGRA 29")!
}

struct Constants {
    static let leftPadding: CGFloat = 17
    static let rightPadding: CGFloat = 17
    static let navBarTopPadding: CGFloat = 60
    static let navBarBottomPadding: CGFloat = 40
    static let navBarHeight: CGFloat = 75
}

