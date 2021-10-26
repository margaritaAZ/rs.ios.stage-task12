//
//  WalletDetailsPresenter.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 30.09.21.
//

import Foundation
import CoreData

protocol WalletDetailsViewProtocol: AnyObject {
    func updateWalletInfo()
    func updateTransactions()
}

protocol WalletDetailsPresenting {
    var title: String { get }
    var amount: String { get }
    var theme: Theme { get }
    var numberOfTransactions: Int { get }
    func transaction(at index: Int) -> Transaction
    func getWallet() -> Wallet
    func edit()
    func back()
    func addTransaction()
    func showTransaction(at index: Int)
}

// MARK: WalletDetailsPresenter
final class WalletDetailsPresenter {
    private var wallet: Wallet
    private var transactions: [Transaction]?
    var router: RouterProtocol?
    weak var view: WalletDetailsViewProtocol?
    
    init(router: RouterProtocol, view: WalletDetailsViewProtocol, wallet: Wallet) {
        self.wallet = wallet
        self.router = router
        self.view = view
        if let transactions = wallet.transactions {
            self.transactions = transactions.allObjects as? [Transaction]
        }
    }
}

// MARK: WalletDetailsPresenting
extension WalletDetailsPresenter: WalletDetailsPresenting {
    var title: String { wallet.title ?? "" }
    var amount: String {
        let symbol = CurrencyModel.getSymbol(forCurrencyCode: wallet.currencyCode!)
        return "\(wallet.balance) \(symbol ?? wallet.currencyCode!)"
    }
    var theme: Theme { Theme.init(rawValue: Int(wallet.themeId)) ?? ThemeManager.defaultTheme }
    func getWallet() -> Wallet { wallet }
    var numberOfTransactions: Int { wallet.transactions?.count ?? 0 }
    func transaction(at index: Int) -> Transaction {
        transactions![index]
    }
    func edit() {
        router?.showEditWallet(wallet: wallet, delegate: self)
    }
    
    func back() {
        router?.pop()
    }
    
    func addTransaction() {
        router?.showEditTransaction(transaction: nil, wallet: wallet, delegate: self)
    }
    
    func showTransaction(at index: Int) {
        if let transactions = self.transactions {
            router?.showTransactionDetails(transaction: transactions[index], wallet: wallet, delegate: self)
        }
    }
}

// MARK: EditWalletDelegate
extension WalletDetailsPresenter: EditWalletDelegate {
    func updateWallet() {
        if let wallet = CoreDataManager.sharedManager.getObject(wallet.objectID) as? Wallet {
            self.wallet = wallet
            view?.updateWalletInfo()
        }
    }
    // TODO: tell this to wallets list
    func walletWasDeleted() {
    }
}

// MARK: TransactionDelegate
extension WalletDetailsPresenter: TransactionDelegate {
    func updateTransaction() {
        if let wallet = CoreDataManager.sharedManager.getObject(wallet.objectID) as? Wallet {
            self.wallet = wallet
            if let transactions = wallet.transactions {
                self.transactions = transactions.allObjects as? [Transaction]
                view?.updateTransactions()
            }
        }
    }
}
