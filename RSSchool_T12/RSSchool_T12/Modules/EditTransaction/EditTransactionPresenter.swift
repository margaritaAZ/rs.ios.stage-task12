//
//  EditTransactionPresenter.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 6.10.21.
//

import Foundation

enum EditTransactionViewType: String {
    case create = "Add transaction"
    case edit = "Edit transaction"
}

enum ChangeType: Int {
    case outcome
    case income
}

protocol TransactionDelegate: AnyObject {
    func updateTransaction()
}

protocol EditTransactionPresenterProtocol {
    var viewTitle: String { get }
    var theme: Theme { get }
//    var changeType: Int { get }
    func back(title: String?, change: String?, changeType: Int, note: String?)
}

final class EditTransactionPresenter {
    private let wallet: Wallet
    private var transaction: Transaction
    private let viewType: EditTransactionViewType
    var router: RouterProtocol?
    weak var delegate: TransactionDelegate?
    
    init(router: RouterProtocol, transaction: Transaction?, wallet: Wallet, delegate: TransactionDelegate?) {
        if let transaction = transaction {
            self.viewType = .edit
            self.transaction = transaction
        } else {
            self.viewType = .create
            self.transaction = Transaction(context: CoreDataManager.sharedManager.managedContext)
            self.transaction.creationDate = Date()
        }
        self.router = router
        self.wallet = wallet
        self.delegate = delegate
    }
}

// MARK: EditTransactionPresenterProtocol
extension EditTransactionPresenter: EditTransactionPresenterProtocol {
    var viewTitle: String { viewType.rawValue }
    var theme: Theme { Theme.init(rawValue: Int(wallet.themeId)) ?? ThemeManager.defaultTheme }
//    var title: String? { transaction.title }
//    var change: String? {
//        if transaction.value >= 0 {
//            return "\(transaction.value)"
//        } else {
//            return "\(-transaction.value)"
//        }
//    }
//    var note: String? { transaction.note }
//    var changeType: Int {
//        if transaction.value > 0 {
//            return ChangeType.income.rawValue
//        } else {
//            return ChangeType.outcome.rawValue
//        }
//    }
    
    func back(title: String?, change: String?, changeType: Int, note: String?) {
        if let title = title, let newChange = change {
            transaction.title = title
            transaction.value = Float(newChange) ?? 0
            if changeType == ChangeType.outcome.rawValue {
                transaction.value = -transaction.value
            }
            transaction.note = note
            transaction.wallet = wallet
            CoreDataManager.sharedManager.saveContext()
            delegate?.updateTransaction()
            router?.pop()
        }
    }
}

