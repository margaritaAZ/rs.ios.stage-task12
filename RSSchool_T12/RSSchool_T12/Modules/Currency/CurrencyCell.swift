//
//  CurrencyCell.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 28.09.21.
//

import UIKit

class CurrencyCell: UICollectionViewCell {
    static let reuseId = "CurrencyCell"
    
    private let glassView = GlassView()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .montserrat(.semiBold, 24)
        label.textColor = .rickBlack
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let codeLabel: UILabel = {
       let label = UILabel()
        label.font = .montserrat(.semiBold, 24)
        label.textColor = .rickBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupAppearance()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupAppearance()
        }
    
    func configure(with currency: CurrencyModel) {
        nameLabel.text = currency.name
        codeLabel.text = currency.code
    }
    
    func setupAppearance() {
        glassView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(glassView)
        glassView.addSubview(nameLabel)
        glassView.addSubview(codeLabel)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            glassView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            glassView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            glassView.topAnchor.constraint(equalTo: contentView.topAnchor),
            glassView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: glassView.leadingAnchor, constant: 30),
            nameLabel.centerYAnchor.constraint(equalTo: glassView.centerYAnchor),
            codeLabel.trailingAnchor.constraint(equalTo: glassView.trailingAnchor, constant: -30),
            codeLabel.centerYAnchor.constraint(equalTo: glassView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: codeLabel.leadingAnchor, constant: -10)
        ])
    }
}
