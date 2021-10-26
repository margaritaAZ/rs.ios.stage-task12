//
//  RoundedTextField.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 26.09.21.
//

import UIKit

class RoundedTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return bounds.insetBy(dx: 20, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.insetBy(dx: 20, dy: 0)
    }
    
    
    func setup() {
        layer.borderColor = UIColor.rickBlack.cgColor
        layer.cornerRadius = 20
        layer.borderWidth = 1
        font = .montserrat(.semiBold, 24)
    }
    
}
