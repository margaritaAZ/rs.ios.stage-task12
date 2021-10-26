//
//  EditWalletPresenter.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 30.09.21.
//

import Foundation

protocol EditWalletVieWProtocol: AnyObject {
    func setTheme(_ theme: Theme)
    func setCurrency(code: String)
    func showAlert()
}

protocol EditWalletDelegate: AnyObject {
    func updateWallet()
    func walletWasDeleted()
}

enum EditWalletViewType: String {
    case create = "Add new wallet"
    case edit = "Edit wallet"
}

protocol EditWalletPresenterProtocol {
    var viewTitle: String { get }
    var theme: Theme { get }
    var currency: CurrencyModel { get }
    var title: String? { get }
    var canDelete: Bool { get }
    func save(newTitle: String?)
    func deleteWallet()
    func selectTheme()
    func selectCurrency()
    func back()
    func changeTitle(_ title: String)
    func discardChanges()
}

final class EditWalletPresenter {
    private var wallet: Wallet
    private let viewType: EditWalletViewType
    weak var view: EditWalletVieWProtocol?
    var router: RouterProtocol?
    weak var delegate: EditWalletDelegate?
    var newTheme: Theme?
    
    init(router: RouterProtocol, view: EditWalletVieWProtocol, wallet: Wallet?, delegate: EditWalletDelegate?) {
        if let wallet = wallet {
            self.viewType = .edit
            self.wallet = wallet
        } else {
            self.viewType = .create
            self.wallet = Wallet(context: CoreDataManager.sharedManager.managedContext)
            self.wallet.currencyCode = CurrencyModel.defaultCode
            self.wallet.themeId = Int16(ThemeManager.defaultTheme.rawValue)
        }
        self.view = view
        self.router = router
        self.delegate = delegate
    }
}

extension EditWalletPresenter: EditWalletPresenterProtocol {
    var title: String? { wallet.title }
    var theme: Theme { Theme.init(rawValue: Int(wallet.themeId)) ?? ThemeManager.defaultTheme }
    var currency: CurrencyModel { CurrencyModel(code: wallet.currencyCode ?? CurrencyModel.defaultCode)}
    var viewTitle: String { viewType.rawValue }
    var canDelete: Bool {
        if viewType == .edit {
            return true
        } else {
            return false
        }
    }
    
    func save(newTitle: String?) {
        guard let title = newTitle else {
            return
        }
        
        wallet.title = title
        wallet.changeDate = Date()
        CoreDataManager.sharedManager.saveContext()
        delegate?.updateWallet()
        router?.pop()
    }
    
    
    func deleteWallet() {
        CoreDataManager.sharedManager.deleteObject(wallet)
        delegate?.walletWasDeleted()
        router?.popToRoot()
    }
    
    func selectTheme() {
        router?.showThemes(delegate: self, currentTheme: theme)
    }
    
    func selectCurrency() {
        router?.showCurrency(delegate: self, wallet: wallet)
    }
    
    func changeTitle(_ title: String) {
        wallet.title = title
    }
    
    func back() {
        if CoreDataManager.sharedManager.contextHasChanges {
            view?.showAlert()
        } else {
            router?.pop()
        }
    }
    
    func discardChanges() {
        CoreDataManager.sharedManager.cancelChanges()
        router?.pop()
    }
}

extension EditWalletPresenter: ThemeDelegate {
    func selectedTheme(_ theme: Theme) {
        wallet.themeId = Int16(theme.rawValue)
        view?.setTheme(theme)
    }
}

extension EditWalletPresenter: CurrencyDelegate {
    //TODO: currency change
    func currencyWasChanged() {
        if let wallet = CoreDataManager.sharedManager.getObject(wallet.objectID) as? Wallet {
            self.wallet = wallet
            if let code = wallet.currencyCode {
                if let symbol = CurrencyModel.getSymbol(forCurrencyCode: code) {
                view?.setCurrency(code: "\(code) \(symbol)")
                }
                view?.setCurrency(code: code)
            }
        }
    }
}
