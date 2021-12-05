//
//  WalletDetailsPresenter.swift
//  RSSchool_T12Tests
//
//  Created by Маргарита Жучик on 8.10.21.
//

import XCTest
@testable import RSSchool_T12

class WalletDetailsPresenterTest: XCTestCase {
    var presenter: WalletDetailsPresenter!
    var view: MockView!
    var router: RouterProtocol!
    var wallet: Wallet!
    var transaction: Transaction!
    let coreDataManager: CoreDataManagerProtocol = TestCoreDataManager()

    override func setUpWithError() throws {
        let wallet = Wallet(context: coreDataManager.managedContext)
        wallet.title = "Unit test"
        wallet.themeId = 1
        wallet.changeDate = Date()
        wallet.currencyCode = "USD"
        
        let transaction = Transaction(context: coreDataManager.managedContext)
        transaction.wallet = wallet
        transaction.creationDate = Date()
        transaction.note = "Note"
        transaction.title = "Title"
        transaction.value = -10
        
        self.transaction = transaction
        self.wallet = wallet
        view = MockView()
        router = Router(navigationController: UINavigationController(), assemblyBuilder: AssemblyBuilder())
        presenter = WalletDetailsPresenter(router: router, view: view, wallet: wallet, coreDataManager: coreDataManager)
    }

    override func tearDownWithError() throws {
        coreDataManager.cancelChanges()
        view = nil
        router = nil
        presenter = nil
        wallet = nil
    }

    func testGetTitle() throws {
        XCTAssertEqual("Unit test", presenter.title)
    }
    
    func testEmptyTitle() throws {
        wallet.title = nil
        XCTAssertEqual(presenter.title, "")
    }
    
    func testAmount() throws {
        XCTAssertEqual(wallet.balance, transaction.value)
        let transaction = Transaction(context: coreDataManager.managedContext)
        transaction.wallet = wallet
        transaction.creationDate = Date()
        transaction.note = "Note"
        transaction.title = "Title"
        transaction.value = 20
        transaction.wallet = wallet
        XCTAssertEqual("10.0 $", presenter.amount)
    }
    
    func testTheme() throws {
        let theme: Theme = Theme.init(rawValue: 1)!
        XCTAssertEqual(theme, presenter.theme)
    }
    
    func testGetWallet() throws {
        XCTAssertEqual(wallet, presenter.getWallet())
    }
    
    func testTransactionsNumber() throws {
        XCTAssertEqual(presenter.numberOfTransactions, 1)
    }
    
    func testNoTransactions() throws {
        wallet.transactions = nil
        XCTAssertEqual(presenter.numberOfTransactions, 0)
    }
    
    func testTransactionAtIndex() throws {
        XCTAssertEqual(presenter.transaction(at: 0), transaction)
    }
    
    
    func test() throws {
        
    }


}
