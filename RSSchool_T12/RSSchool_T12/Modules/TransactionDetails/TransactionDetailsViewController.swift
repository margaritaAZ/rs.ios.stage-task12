//
//  TransactionDetailsViewController.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 6.10.21.
//

import UIKit

class TransactionDetailsViewController: UIViewController {
    
    var presenter: TransactionDetailsPresenterProtocol!
    
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
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
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
    
    private lazy var contentView = GlassView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(.semiBold, 36)
        label.text = presenter.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editButton: RoundButton = {
        let button = RoundButton(type: .edit)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(.semiBold, 48)
        label.text = presenter.change
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noteView = GlassView()
    
    private lazy var noteTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(.semiBold, 24)
        label.text = "Note"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noteTextLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(.semiBold, 18)
        label.text = presenter.note
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.amaranthRed, for: .normal)
        button.titleLabel?.font = .montserrat(.medium, 20)
        button.layer.cornerRadius = 20
        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteTransaction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppereance()
    }
}

private extension TransactionDetailsViewController {
    @objc func deleteTransaction() {
        presenter.deleteTransaction()
    }
    
    func setupAppereance() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        noteView.translatesAutoresizingMaskIntoConstraints = false
        view.layer.insertSublayer(backgroundLayer, at: 0)
        view.addSubview(navigationBar)
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(valueLabel)
        contentView.addSubview(noteView)
        noteView.addSubview(noteTitleLabel)
        noteView.addSubview(noteTextLabel)
        contentView.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.navBarTopPadding),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leftPadding),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.rightPadding),
            navigationBar.heightAnchor.constraint(equalToConstant: Constants.navBarHeight),
            contentView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: Constants.navBarBottomPadding),
            contentView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            editButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),
            editButton.heightAnchor.constraint(equalToConstant: 40),
            editButton.widthAnchor.constraint(equalToConstant: 40),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            noteView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 40),
            noteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            noteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),
            noteTitleLabel.topAnchor.constraint(equalTo: noteView.topAnchor, constant: 30),
            noteTitleLabel.leadingAnchor.constraint(equalTo: noteView.leadingAnchor, constant: 20),
            noteTextLabel.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 20),
            noteTextLabel.leadingAnchor.constraint(equalTo: noteTitleLabel.leadingAnchor),
            noteTextLabel.bottomAnchor.constraint(equalTo: noteView.bottomAnchor, constant: -34),
            deleteButton.topAnchor.constraint(equalTo: noteView.bottomAnchor, constant: 20),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -33),
            deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 114),
            deleteButton.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
    
    @objc func back() {
        presenter.back()
    }
}
