//
//  WalletCell.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 29.09.21.
//

import UIKit

class WalletCell: UICollectionViewCell {
    
    static let reuseId = "WalletCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var lastChangeTitleLabel: UILabel!
    @IBOutlet weak var lastChangeDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppereance()
    }
    
    func configure(with wallet: Wallet) {
        titleLabel.text = wallet.title
        let symbol = CurrencyModel.getSymbol(forCurrencyCode: wallet.currencyCode!)
        amountLabel.text = "\(wallet.balance) \(symbol ?? wallet.currencyCode!)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        if let date = wallet.changeDate {
            lastChangeDateLabel.text = dateFormatter.string(from: date)
        }
    }
    
    func setupAppereance() {
        titleLabel.font = .montserrat(.semiBold, 24)
        amountLabel.font = .montserrat(.semiBold, 24)
        lastChangeTitleLabel.font = .montserrat(.semiBold, 18)
        lastChangeDateLabel.font = .montserrat(.regular, 18)
    }
}
