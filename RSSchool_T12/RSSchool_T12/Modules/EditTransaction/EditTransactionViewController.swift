//
//  EditTransactionViewController.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 6.10.21.
//

import UIKit

class EditTransactionViewController: UIViewController {
    
    var presenter: EditTransactionPresenterProtocol!
    
    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.contents = presenter.theme.backgroundImage.cgImage
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 2.16, b: 0, c: 0, d: 1, tx: -0.58, ty: 0))
        layer.bounds = view.bounds
        layer.position = view.center
        return layer
    }()
    
    private let backButton: RoundButton = {
        let button = RoundButton(type: .back)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var navigationBar: GlassView = {
        let view = NavigationBarBuilder()
            .setLeftButton(backButton)
            .setViewTitle(presenter.viewTitle)
            .build()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleTextField: TextFieldView = {
        let view = TextFieldView(title: "Title")
        view.textField.delegate = self
        view.textField.tag = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var changeTextField: TextFieldView = {
        let view = TextFieldView(title: "Change", segmentedControl: changeType)
        view.textField.keyboardType = .decimalPad
        view.textField.delegate = self
        view.textField.tag = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var noteTextField: TextFieldView = {
        let view = TextFieldView(title: "Note")
        view.textField.delegate = self
        view.textField.tag = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppereance()
    }
    
    private lazy var changeType: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Outcome", "Income"])
        view.selectedSegmentIndex = 0
        return view
    }()
}

private extension EditTransactionViewController {
    @objc func backButtonTapped() {
        presenter.back(title: titleTextField.textField.text, change: changeTextField.textField.text, changeType: changeType.selectedSegmentIndex, note: noteTextField.textField.text)
    }
    
    func setupAppereance() {
        view.layer.insertSublayer(backgroundLayer, at: 0)
        view.addSubview(navigationBar)
        view.addSubview(titleTextField)
        view.addSubview(changeTextField)
        view.addSubview(noteTextField)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.navBarTopPadding),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leftPadding),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.rightPadding),
            navigationBar.heightAnchor.constraint(equalToConstant: Constants.navBarHeight),
            titleTextField.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: Constants.navBarBottomPadding),
            titleTextField.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            changeTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            changeTextField.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            changeTextField.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            
            noteTextField.topAnchor.constraint(equalTo: changeTextField.bottomAnchor, constant: 20),
            noteTextField.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            noteTextField.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor)
        ])
    }
}

extension EditTransactionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
