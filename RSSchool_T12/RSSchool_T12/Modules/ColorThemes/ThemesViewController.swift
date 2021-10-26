//
//  SelectThemeViewController.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 26.09.21.
//

import UIKit

class ThemesViewController: CollectionViewController {
    
    private lazy var backButton: RoundButton = {
        let button = RoundButton(type: .back)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    var selectedTheme: IndexPath?
    var presenter: ThemesPresesenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTheme = IndexPath(item: presenter.selectedThemeId, section: 0)
        setupAppearance()
    }
    
    @objc func back() {
        presenter.saveTheme(Theme.init(rawValue: selectedTheme?.item ?? 0) ?? ThemeManager.defaultTheme)
    }
    
    override func setupAppearance() {
        collectionView.selectItem(at: selectedTheme, animated: true, scrollPosition: .top)
        backgroundLayer.contents = Theme.init(rawValue: presenter.selectedThemeId)?.backgroundImage.cgImage
        let navigationView = NavigationBarBuilder()
            .setViewTitle("Color themes")
            .setLeftButton(backButton)
            .build()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar = navigationView
        super.setupAppearance()
        collectionView.register(ThemeCell.self, forCellWithReuseIdentifier: ThemeCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: UICollectionViewDataSource
extension ThemesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCell.reuseId, for: indexPath)
        
        if let cell = cell as? ThemeCell {
            cell.configure(with: presenter.theme(at: indexPath.item).backgroundImage)
        }
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath != selectedTheme {
            selectedTheme = indexPath
            self.collectionView.reloadItems(at: [indexPath])
            backgroundLayer.contents = Theme.init(rawValue: indexPath.item)?.backgroundImage.cgImage
        }
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == selectedTheme {
            return CGSize(width: UIScreen.main.bounds.width-110, height: 160)
        } else {
            return CGSize(width: UIScreen.main.bounds.width-34, height: 160)
        }
    }
}

