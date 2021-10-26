//
//  CollectionViewController.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 29.09.21.
//

import UIKit

class CollectionViewController: UIViewController {
    
    lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.contents = ThemeManager().getBackgroundImage(theme:ThemeManager.defaultTheme).cgImage
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 2.16, b: 0, c: 0, d: 1, tx: -0.58, ty: 0))
        layer.bounds = view.bounds
        layer.position = view.center
        return layer
    }()
    
    var navigationBar = GlassView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupAppearance() {
        view.layer.insertSublayer(backgroundLayer, at: 0)
        view.addSubview(navigationBar)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leftPadding),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.rightPadding),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.navBarTopPadding),
            navigationBar.heightAnchor.constraint(equalToConstant: Constants.navBarHeight),
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 30, left: Constants.leftPadding, bottom: 10, right: Constants.rightPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}

