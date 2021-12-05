//
//  TransactionDetailsPresenter.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 6.10.21.
//

import Foundation

protocol TransactionDetailsPresenterProtocol {
    var viewTitle: String { get }
    var theme: Theme { get }
    var title: String { get }
    var change: String { get }
    var note: String { get }
    func back()
    func deleteTransaction()
}

final class TransactionDetailsPresenter {
    private let wallet: Wallet
    private var transaction: Transaction
    private var router: RouterProtocol?
    private weak var delegate: TransactionDelegate?
    private var coreData: CoreDataManagerProtocol
    
    init(router: RouterProtocol, transaction: Transaction, wallet: Wallet, delegate: TransactionDelegate?, coreData: CoreDataManagerProtocol) {
        self.transaction = transaction
        self.router = router
        self.wallet = wallet
        self.delegate = delegate
        self.coreData = coreData
    }
}

extension TransactionDetailsPresenter: TransactionDetailsPresenterProtocol {
    var viewTitle: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: transaction.creationDate!)
    }
    var theme: Theme { Theme(rawValue: Int(wallet.themeId)) ?? ThemeManager.defaultTheme }
    var title: String { transaction.title! }
    var change: String { "\(transaction.value)" }
    var note: String { transaction.note ?? "" }
    
    func deleteTransaction() {
        coreData.deleteObject(transaction)
        delegate?.updateTransaction()
        router?.pop()
    }
    
    func back() {
        router?.pop()
    }
}

