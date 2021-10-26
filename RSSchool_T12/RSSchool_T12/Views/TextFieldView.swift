//
//  TextFieldView.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 6.10.21.
//

import UIKit

class TextFieldView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .montserrat(.semiBold, 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var textField: RoundedTextField = {
        let textField = RoundedTextField()
        textField.placeholder = "Type here..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var backgroundView: GlassView = {
        let view = GlassView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var segmentedControl: UISegmentedControl?
    
    init(title: String, segmentedControl: UISegmentedControl? = nil) {
        super.init(frame: .zero)
        titleLabel.text = title
        self.segmentedControl = segmentedControl
        setupAppereance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupAppereance() {
        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(textField)
       
       if let segmentedControl = segmentedControl {
           segmentedControl.translatesAutoresizingMaskIntoConstraints = false
           backgroundView.addSubview(segmentedControl)
           segmentedControl.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
           segmentedControl.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20).isActive = true
           segmentedControl.widthAnchor.constraint(equalToConstant: 204).isActive = true
           segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
       }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 73)
        ])
    }
}
