//
//  WalletsListPresenter.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 29.09.21.
//

import Foundation
import CoreData

protocol WalletsListViewProtocol: AnyObject {
    func updateWallets()
    func updateBackground()
}

protocol WalletsListPresenterProtocol {
    var numberOfItems: Int { get }
    var theme: Theme { get }
    func wallet(at index: Int) -> Wallet
    func showWallet(_  wallet: Wallet)
    func addWallet()
}

class WalletsListPresenter {
    private weak var view: WalletsListViewProtocol?
    private var wallets = [Wallet]()
    private var router: RouterProtocol?
    private let coreDataManager: CoreDataManagerProtocol
    private lazy var dateSortDescriptor: NSSortDescriptor = {
        return NSSortDescriptor(key: #keyPath(Wallet.changeDate), ascending: false)
    }()
    required init(router: RouterProtocol, view: WalletsListViewProtocol, coreData: CoreDataManagerProtocol) {
        self.view = view
        self.router = router
        self.coreDataManager = coreData
        getWallets()
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: nil)
    }
    
    func getWallets() {
        let request: NSFetchRequest<Wallet> = Wallet.fetchRequest()
        request.sortDescriptors = [dateSortDescriptor]
        do {
            wallets = try coreDataManager.managedContext.fetch(request)
        } catch {
            print("Error fetching \(error)")
        }
    }
    
    @objc func contextDidSave(_ notification: Notification) {
        getWallets()
        view?.updateWallets()
        view?.updateBackground()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension WalletsListPresenter: WalletsListPresenterProtocol {
    var numberOfItems: Int {
        wallets.count
    }
    
    var theme: Theme {
        if let lastWallet = wallets.first {
            return Theme.init(rawValue: Int(lastWallet.themeId)) ?? ThemeManager.defaultTheme
        }
        return ThemeManager.defaultTheme
    }
    
    func wallet(at index: Int) -> Wallet {
        wallets[index]
    }
    
    func showWallet(_ wallet: Wallet) {
        router?.showWalletDetail(wallet: wallet)
    }
    
    func addWallet() {
        router?.showEditWallet(wallet: nil, delegate: nil)
    }
}
