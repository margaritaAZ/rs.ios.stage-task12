//
//  ThemeCell.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 28.09.21.
//

import UIKit

class ThemeCell: UICollectionViewCell {
    static let reuseId = "ThemeCell"
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.sizeToFit()
        
        return view
    }()
    
    private let glassView = GlassView()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupAppearance()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupAppearance()
        }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    func setupAppearance() {
        glassView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(glassView)
        glassView.addSubview(imageView)
        NSLayoutConstraint.activate([
            glassView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            glassView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            glassView.topAnchor.constraint(equalTo: contentView.topAnchor),
            glassView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: glassView.leadingAnchor, constant: 25),
            imageView.trailingAnchor.constraint(equalTo: glassView.trailingAnchor, constant: -25),
            imageView.topAnchor.constraint(equalTo: glassView.topAnchor, constant: 30),
            imageView.bottomAnchor.constraint(equalTo: glassView.bottomAnchor, constant: -30)
        ])
        
    }
}
