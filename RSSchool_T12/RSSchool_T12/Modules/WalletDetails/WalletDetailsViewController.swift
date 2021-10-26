//
//  WalletDetailsViewController.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 30.09.21.
//

import UIKit

class WalletDetailsViewController: UIViewController {
    
    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.contents = ThemeManager().getBackgroundImage(theme: presenter.theme).cgImage
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 2.16, b: 0, c: 0, d: 1, tx: -0.58, ty: 0))
        layer.bounds = view.bounds
        layer.position = view.center
        return layer
    }()
    
    private let backButton: RoundButton = {
        let button = RoundButton(type: .menu)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    private let settingsButton: RoundButton = {
        let button = RoundButton(type: .settings)
        button.addTarget(self, action: #selector(editWallet), for: .touchUpInside)
        return button
    }()
    
    private var navigationBarBuilder = NavigationBarBuilder()
    
    private lazy var navigationBar: GlassView = {
        let navigationBar = navigationBarBuilder
            .setLeftButton(backButton)
            .setRightButton(settingsButton)
            .setViewTitle(presenter.title)
            .build()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    
    private let cashView = GlassView()
    private let transactionsView = GlassView()
    
    lazy var cashLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(.medium, 36)
        label.textColor = .rickBlack
        label.text = presenter.amount
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transactionsLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(.semiBold, 17)
        label.textColor = .rickBlack
        label.text = "Transactions"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addTransactionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Add transaction", for: .normal)
        button.setTitleColor(.greenBlueCrayola, for: .normal)
        button.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
        button.titleLabel?.font = .montserrat(.medium, 18)
        button.layer.cornerRadius = 18
        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellWithReuseIdentifier: TransactionCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var presenter: WalletDetailsPresenting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
}

// MARK: UICollectionViewDataSource
extension WalletDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfTransactions
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.reuseId, for: indexPath)
        if let cell = cell as? TransactionCell {
            cell.configure(with: presenter.transaction(at: indexPath.item))
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension WalletDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showTransaction(at: indexPath.item)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WalletDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 90)
    }
}


//MARK: WalletDetailsViewProtocol
extension WalletDetailsViewController: WalletDetailsViewProtocol {
    func updateWalletInfo() {
        navigationBarBuilder.viewTitle?.text = presenter.title
        backgroundLayer.contents = ThemeManager().getBackgroundImage(theme: presenter.theme).cgImage
        cashLabel.text = presenter.amount
    }
    
    func updateTransactions() {
        collectionView.reloadData()
        cashLabel.text = presenter.amount
    }
}

// MARK: private interface WalletDetailsViewController
private extension WalletDetailsViewController {
    @objc func addTransaction() {
        presenter.addTransaction()
    }
    
    @objc func back() {
        presenter.back()
    }
    
    @objc func editWallet() {
        presenter.edit()
    }
    
    func setupAppearance() {
        cashView.translatesAutoresizingMaskIntoConstraints = false
        transactionsView.translatesAutoresizingMaskIntoConstraints = false
        view.layer.insertSublayer(backgroundLayer, at: 0)
        view.addSubview(navigationBar)
        view.addSubview(cashView)
        view.addSubview(transactionsView)
        cashView.addSubview(cashLabel)
        transactionsView.addSubview(transactionsLabel)
        transactionsView.addSubview(collectionView)
        transactionsView.addSubview(addTransactionButton)
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leftPadding),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.rightPadding),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.navBarTopPadding),
            navigationBar.heightAnchor.constraint(equalToConstant: Constants.navBarHeight),
            cashView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: Constants.navBarBottomPadding),
            cashView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            cashView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            cashView.heightAnchor.constraint(equalToConstant: 100),
            cashLabel.centerXAnchor.constraint(equalTo: cashView.centerXAnchor),
            cashLabel.centerYAnchor.constraint(equalTo: cashView.centerYAnchor),
            transactionsView.topAnchor.constraint(equalTo: cashView.bottomAnchor, constant: 20),
            transactionsView.leadingAnchor.constraint(equalTo: cashView.leadingAnchor),
            transactionsView.trailingAnchor.constraint(equalTo: cashView.trailingAnchor),
            transactionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            transactionsLabel.topAnchor.constraint(equalTo: transactionsView.topAnchor, constant: 24),
            transactionsLabel.leadingAnchor.constraint(equalTo: transactionsView.leadingAnchor, constant: 36),
            addTransactionButton.centerYAnchor.constraint(equalTo: transactionsLabel.centerYAnchor),
            addTransactionButton.trailingAnchor.constraint(equalTo: transactionsView.trailingAnchor, constant: -28),
            addTransactionButton.heightAnchor.constraint(equalToConstant: 35),
            addTransactionButton.widthAnchor.constraint(equalToConstant: 170),
            collectionView.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: transactionsView.leadingAnchor, constant: 27),
            collectionView.trailingAnchor.constraint(equalTo: transactionsView.trailingAnchor, constant: -28),
            collectionView.bottomAnchor.constraint(equalTo: transactionsView.bottomAnchor, constant: -30)
            ])
    }
}
