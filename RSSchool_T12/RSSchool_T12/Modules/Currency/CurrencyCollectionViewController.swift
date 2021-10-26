//
//  CurrencyCollectionViewController.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 28.09.21.
//

import UIKit

class CurrencyCollectionViewController: CollectionViewController {
    private lazy var backButton: RoundButton = {
        let button = RoundButton(type: .back)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()

    var presenter: CurrencyPresenterProtocol!
    var selectedCurrency: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCurrency = IndexPath(item: presenter.getSelectedCurrencyIndex(), section: 0)
        self.collectionView.register(CurrencyCell.self, forCellWithReuseIdentifier: CurrencyCell.reuseId)
        setupAppearance()

    }
    
    override func setupAppearance() {
        if let selectedCurrency = selectedCurrency {
            //FIXME: scroll to selected currency
            collectionView.selectItem(at: selectedCurrency, animated: true, scrollPosition: .centeredHorizontally)
            collectionView.scrollToItem(at: selectedCurrency, at: .centeredVertically, animated: true)
        }
        backgroundLayer.contents = presenter.theme.backgroundImage.cgImage
        let navigationView = NavigationBarBuilder()
            .setViewTitle("Wallet currency")
            .setLeftButton(backButton)
            .build()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar = navigationView
        super.setupAppearance()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func back() {
        if let selectedCurrency = selectedCurrency {
            presenter.saveCurrency(code: presenter.currency(at: selectedCurrency.item).code)
        }
    }
}

    // MARK: UICollectionViewDataSource
extension CurrencyCollectionViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCell.reuseId, for: indexPath)
    
        if let cell = cell as? CurrencyCell {
            cell.configure(with: presenter.currency(at: indexPath.item))
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if indexPath != selectedCurrency {
             selectedCurrency = indexPath
             self.collectionView.reloadItems(at: [indexPath])
         }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == selectedCurrency {
            return CGSize(width: UIScreen.main.bounds.width-110, height: 60)
        } else {
            return CGSize(width: UIScreen.main.bounds.width-34, height: 75)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
