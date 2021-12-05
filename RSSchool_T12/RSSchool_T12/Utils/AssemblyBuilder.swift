//
//  ModuleBuilder.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 2.10.21.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createWalletsListModule(router: RouterProtocol, coreDataManager: CoreDataManagerProtocol) -> UIViewController
    func createWalletsDetailModule(router: RouterProtocol, wallet: Wallet, coreDataManager: CoreDataManagerProtocol) -> UIViewController
    func createEditWalletModule(router: RouterProtocol, wallet: Wallet?, delegate: EditWalletDelegate?, coreDataManager: CoreDataManagerProtocol) -> UIViewController
    func createThemesListModule(router: RouterProtocol, delegate: ThemeDelegate?, theme: Theme) -> UIViewController
    func createCurrencyListModule(router: RouterProtocol, delegate: CurrencyDelegate?, wallet: Wallet) -> UIViewController
    func createEditTransactionModule(router: RouterProtocol, transaction: Transaction?, wallet: Wallet, delegate: TransactionDelegate?, coreDataManager: CoreDataManagerProtocol) -> UIViewController
    func createTransactionDetailsModule(router: RouterProtocol, transaction: Transaction, wallet: Wallet, delegate: TransactionDelegate?, coreData: CoreDataManagerProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createWalletsListModule(router: RouterProtocol, coreDataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = WalletsListViewController()
        let presenter = WalletsListPresenter(router: router, view: view, coreData: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func createWalletsDetailModule(router: RouterProtocol, wallet: Wallet, coreDataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = WalletDetailsViewController()
        let presenter = WalletDetailsPresenter(router: router, view: view, wallet: wallet, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func createEditWalletModule(router: RouterProtocol, wallet: Wallet?, delegate: EditWalletDelegate?, coreDataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = EditWalletViewController()
        let presenter = EditWalletPresenter(router: router, view: view, wallet: wallet, delegate: delegate, coreData: coreDataManager)
        presenter.delegate = delegate
        view.presenter = presenter
        return view
    }
    
    func createThemesListModule(router: RouterProtocol, delegate: ThemeDelegate?, theme: Theme) -> UIViewController {
        let presenter = ThemesPresenter(router: router, delegate: delegate, currentTheme: theme)
        let view = ThemesViewController()
        view.presenter = presenter
        return view
    }
    
    func createCurrencyListModule(router: RouterProtocol, delegate: CurrencyDelegate?, wallet: Wallet) -> UIViewController {
        let presenter = CurrencyPresenter(router: router, delegate: delegate, wallet: wallet)
        let view = CurrencyCollectionViewController()
        view.presenter = presenter
        return view
    }
    
    func createEditTransactionModule(router: RouterProtocol, transaction: Transaction?, wallet: Wallet, delegate: TransactionDelegate?, coreDataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = EditTransactionViewController()
        let presenter = EditTransactionPresenter(router: router, transaction: transaction, wallet: wallet, delegate: delegate, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func createTransactionDetailsModule(router: RouterProtocol, transaction: Transaction, wallet: Wallet, delegate: TransactionDelegate?, coreData: CoreDataManagerProtocol) -> UIViewController {
        let view = TransactionDetailsViewController()
        let presenter = TransactionDetailsPresenter(router: router, transaction: transaction, wallet: wallet, delegate: delegate, coreData: coreData)
        view.presenter = presenter
        return view
    }
}
