//
//  RouterTest.swift
//  RSSchool_T12Tests
//
//  Created by Маргарита Жучик on 10.10.21.
//

import XCTest
@testable import RSSchool_T12

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class RouterTest: XCTestCase {
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AssemblyBuilder()
    let coreDataManager: CoreDataManagerProtocol = TestCoreDataManager()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
        coreDataManager.cancelChanges()
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testRouter() throws {
        let wallet = Wallet(context: coreDataManager.managedContext)
        
        router.showWalletDetail(wallet: wallet)
        XCTAssertTrue(navigationController.presentedVC is WalletDetailsViewController)
        
        router.showEditWallet(wallet: nil, delegate: nil)
        XCTAssertTrue(navigationController.presentedVC is EditWalletViewController)
        
        router.showThemes(delegate: nil, currentTheme: ThemeManager.defaultTheme)
        XCTAssertTrue(navigationController.presentedVC is ThemesViewController)
        
        router.showCurrency(delegate: nil, wallet: wallet)
        XCTAssertTrue(navigationController.presentedVC is CurrencyCollectionViewController)
        
        router.showEditTransaction(transaction: nil, wallet: wallet, delegate: nil)
        XCTAssertTrue(navigationController.presentedVC is EditTransactionViewController)
        
        let transaction = Transaction(context: coreDataManager.managedContext)
        
        router.showTransactionDetails(transaction: transaction, wallet: wallet, delegate: nil)
        XCTAssertTrue(navigationController.presentedVC is TransactionDetailsViewController)
        
    }
}
