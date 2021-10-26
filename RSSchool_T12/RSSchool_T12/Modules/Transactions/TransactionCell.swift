//
//  TransactionCell.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 5.10.21.
//

import UIKit

class TransactionCell: UICollectionViewCell {

    @IBOutlet weak var imageCategoryView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    static let reuseId = "TransactionCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    func configure(with transaction: Transaction) {
        titleLabel.text = transaction.title
        if transaction.value > 0 {
            valueLabel.text = "+\(transaction.value)"
            valueLabel.textColor = .celadon
        } else {
            valueLabel.text = "\(transaction.value)"
            valueLabel.textColor = .amaranthRed
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        if let date = transaction.creationDate {
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
    
    func setupAppearance() {
        imageCategoryView.backgroundColor = .clear
        imageCategoryView.layer.borderWidth = 1
        imageCategoryView.layer.borderColor = UIColor.rickBlack.cgColor
        imageCategoryView.layer.cornerRadius = 10
        
        titleLabel.font = .montserrat(.bold, 18)
        dateLabel.font = .montserrat(.semiBold, 14)
        valueLabel.font = .montserrat(.semiBold, 24)
    }

}
