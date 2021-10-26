//
//  RoundButton.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 24.09.21.
//

enum RoundButtonTypes: String {
    case add = "plus"
    case delete = "trash"
    case edit = "pencil"
    case back = "chevron.compact.left"
    case settings = "gear"
    case menu = "text.justifyleft"
}

import UIKit

class RoundButton: UIButton {
    private var imageName = String()
    private var color: UIColor = .greenBlueCrayola
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                tintColor = .deepSaffron
                layer.borderColor = UIColor.deepSaffron.cgColor
            } else {
                tintColor = color
                layer.borderColor = color.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    init(type: RoundButtonTypes) {
        imageName = type.rawValue
        if type == .delete {
            color = .amaranthRed
        }
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        setupButton()
    }
    
    func setupButton() {
        layer.cornerRadius = bounds.height/2
        layer.borderColor = color.cgColor
        layer.borderWidth = 1.5
        backgroundColor = .clear
        let buttonImage = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        setImage(buttonImage, for: .normal)
        tintColor = color
    }

}
