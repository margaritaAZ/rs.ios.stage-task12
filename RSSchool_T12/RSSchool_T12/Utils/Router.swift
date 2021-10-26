//
//  Router.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 2.10.21.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showWalletDetail(wallet: Wallet)
    func showEditWallet(wallet: Wallet?, delegate: EditWalletDelegate?)
    func showThemes(delegate: ThemeDelegate?, currentTheme: Theme)
    func showCurrency(delegate: CurrencyDelegate?, wallet: Wallet)
    func showEditTransaction(transaction: Transaction?, wallet: Wallet, delegate: TransactionDelegate?)
    func showTransactionDetails(transaction: Transaction, wallet: Wallet, delegate: TransactionDelegate?)
    func popToRoot()
    func pop()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let walletsListController = assemblyBuilder?.createWalletsListModule(router: self) else { return }
            navigationController.viewControllers = [walletsListController]
        }
    }
    
    func showWalletDetail(wallet: Wallet) {
        if let navigationController = navigationController {
            guard let walletsListController = assemblyBuilder?.createWalletsDetailModule(router: self, wallet: wallet)
            else { return }
            navigationController.pushViewController(walletsListController, animated: true)
        }
    }
    
    func showEditWallet(wallet: Wallet?, delegate: EditWalletDelegate?) {
        if let navigationController = navigationController {
            guard let editWalletController = assemblyBuilder?.createEditWalletModule(router: self, wallet: wallet, delegate: delegate)
            else { return }
            navigationController.pushViewController(editWalletController, animated: true)
        }
    }
    
    func showThemes(delegate: ThemeDelegate?, currentTheme: Theme) {
        if let navigationController = navigationController {
            guard let themesController = assemblyBuilder?.createThemesListModule(router: self, delegate: delegate, theme: currentTheme)
            else { return }
            navigationController.pushViewController(themesController, animated: true)
        }
    }
    
    func showCurrency(delegate: CurrencyDelegate?, wallet: Wallet) {
        if let navigationController = navigationController {
            guard let currencyController = assemblyBuilder?.createCurrencyListModule(router: self, delegate: delegate, wallet: wallet)
            else { return }
            navigationController.pushViewController(currencyController, animated: true)
        }
    }
    
    func showEditTransaction(transaction: Transaction?, wallet: Wallet, delegate: TransactionDelegate?) {
        if let navigationController = navigationController {
            guard let editTransactionController = assemblyBuilder?.createEditTransactionModule(router: self, transaction: transaction, wallet: wallet, delegate: delegate)
            else { return }
            navigationController.pushViewController(editTransactionController, animated: true)
        }
    }
    
    func showTransactionDetails(transaction: Transaction, wallet: Wallet, delegate: TransactionDelegate?) {
        if let navigationController = navigationController {
            guard let vc = assemblyBuilder?.createTransactionDetailsModule(router: self, transaction: transaction, wallet: wallet, delegate: delegate)
            else { return }
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func pop() {
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
        }
    }
}
