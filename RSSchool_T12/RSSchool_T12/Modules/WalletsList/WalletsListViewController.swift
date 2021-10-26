//
//  WalletsListViewController.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 23.09.21.
//

import UIKit

class WalletsListViewController: CollectionViewController {
    
    private lazy var addButton:RoundButton = {
        let button = RoundButton(type: .add)
        button.addTarget(self, action: #selector(addWallet), for: .touchUpInside)
        return button
    }()
    
    var presenter: WalletsListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func setupAppearance() {
        backgroundLayer.contents = presenter.theme.backgroundImage.cgImage
        let navigationView = NavigationBarBuilder()
            .setViewTitle("Wallets")
            .setRightButton(addButton)
            .build()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar = navigationView
        super.setupAppearance()
        collectionView.register(UINib(nibName: "WalletCell", bundle: nil), forCellWithReuseIdentifier: WalletCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension WalletsListViewController: WalletsListViewProtocol {
    func updateBackground() {
        backgroundLayer.contents = presenter.theme.backgroundImage.cgImage
    }
    
    func updateWallets() {
           collectionView.reloadData()
       }
}

private extension WalletsListViewController {
    @objc func addWallet() {
        presenter.addWallet()
    }
}

//MARK: UICollectionViewDataSource
extension WalletsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCell", for: indexPath)
        if let cell = cell as? WalletCell {
            cell.configure(with: presenter.wallet(at: indexPath.item))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - Constants.leftPadding*2, height: 208)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let wallet = presenter.wallet(at: indexPath.item)
        presenter.showWallet(wallet)
    }
}

