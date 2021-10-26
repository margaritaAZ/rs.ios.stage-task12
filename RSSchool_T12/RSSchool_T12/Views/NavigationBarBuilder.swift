//
//  NavigationBarBuilder.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 25.09.21.
//

import Foundation
import UIKit

class NavigationBarBuilder {
    var viewTitle: UILabel?
    var rightButton: RoundButton?
    var leftButton: RoundButton?
    private lazy var view = GlassView()
    
    func setViewTitle(_ title: String) -> NavigationBarBuilder {
        viewTitle = UILabel()
        viewTitle?.text = title
        viewTitle?.textColor = .black
        viewTitle?.font = .montserrat(.semiBold, 24)
        viewTitle?.lineBreakMode = .byTruncatingTail
        viewTitle?.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setRightButton(_ button: RoundButton) -> NavigationBarBuilder {
        rightButton = button
        rightButton?.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setLeftButton(_ button: RoundButton) -> NavigationBarBuilder {
        leftButton = button
        leftButton?.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func build() -> GlassView {
        guard let viewTitle = viewTitle else {
            return view
        }
        view.addSubview(viewTitle)
        viewTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        if let leftButton = leftButton {
            view.addSubview(leftButton)
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            leftButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            leftButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            leftButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            viewTitle.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 20).isActive = true
        } else {
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        }
        if let rightButton = rightButton {
            view.addSubview(rightButton)
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true
            rightButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            rightButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            rightButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            viewTitle.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -10).isActive = true
        } else {
            viewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        }
        
        return view
    }
}
