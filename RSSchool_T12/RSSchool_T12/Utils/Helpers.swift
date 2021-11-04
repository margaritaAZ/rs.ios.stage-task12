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
    static let amaranthRed: UIColor = UIColor(named: "Amaranth Red") ?? .red
    static let babyPowder: UIColor = UIColor(named: "Baby Powder") ?? .white
    static let celadon: UIColor = UIColor(named: "Celadon") ?? .green
    static let darkPurple: UIColor = UIColor(named: "Dark Purple") ?? .black
    static let deepSaffron: UIColor = UIColor(named: "Deep Saffron") ?? .orange
    static let greenBlueCrayola: UIColor = UIColor(named: "Green Blue Crayola") ?? .blue
    static let honeydew: UIColor = UIColor(named: "Honeydew") ?? .gray
    static let lightCyan: UIColor = UIColor(named: "Light Cyan") ?? .cyan
    static let pink: UIColor = UIColor(named: "Pink") ?? .pink
    static let rickBlack: UIColor = UIColor(named: "Rick Black FOGRA 29") ?? .black
}

struct Constants {
    static let leftPadding: CGFloat = 17
    static let rightPadding: CGFloat = 17
    static let navBarTopPadding: CGFloat = 60
    static let navBarBottomPadding: CGFloat = 40
    static let navBarHeight: CGFloat = 75
}

