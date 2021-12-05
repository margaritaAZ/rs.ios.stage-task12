//
//  WalletsListPresenterTest.swift
//  RSSchool_T12Tests
//
//  Created by Маргарита Жучик on 7.10.21.
//

import XCTest
@testable import RSSchool_T12

class MockView: WalletsListViewProtocol, WalletDetailsViewProtocol, EditWalletVieWProtocol {
    func setTheme(_ theme: Theme) {}
    func setCurrency(code: String) {}
    func showAlert() {}
    func updateWalletInfo() {}
    func updateTransactions() {}
    func updateWallets() {}
    func updateBackground() {}
}

class WalletsListPresenterTest: XCTestCase {
    var view: MockView!
    var presenter: WalletsListPresenter!
    var router: RouterProtocol!
    var wallets = [Wallet]()
    let coreDataManager: CoreDataManagerProtocol = TestCoreDataManager()

    
    override func setUpWithError() throws {
        let wallet = Wallet(context: coreDataManager.managedContext)
        wallet.title = "Unit test"
        wallet.themeId = 1
        wallet.changeDate = Date()
        wallet.currencyCode = "USD"
        wallets.append(wallet)
        
        view = MockView()
        router = Router(navigationController: UINavigationController(), assemblyBuilder: AssemblyBuilder())
        presenter = WalletsListPresenter(router: router, view: view, coreData: coreDataManager)
    }
    
    override func tearDownWithError() throws {
        coreDataManager.cancelChanges()
        view = nil
        router = nil
        presenter = nil
        wallets = [Wallet]()
    }
    
    func testTheme() throws {
        let theme: Theme = Theme.init(rawValue: 1)!
        XCTAssertEqual(theme, presenter.theme)
    }
    
    func testNumberOfItems() throws {
        XCTAssertNotEqual(presenter.numberOfItems, 0)
        XCTAssertEqual(presenter.numberOfItems, 1)
    }
    
    func testWalletAt() throws {
        XCTAssertEqual(wallets[0], presenter.wallet(at: 0))
    }
}
