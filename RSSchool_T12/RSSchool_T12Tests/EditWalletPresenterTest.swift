//
//  EditWalletPresenterTest.swift
//  RSSchool_T12Tests
//
//  Created by Маргарита Жучик on 10.10.21.
//

import XCTest
@testable import RSSchool_T12

class EditWalletPresenterTest: XCTestCase {
    var presenter: EditWalletPresenter!
    var view: MockView!
    var router: RouterProtocol!
    var wallet: Wallet!

    override func setUpWithError() throws {
        let wallet = Wallet(context: CoreDataManager.sharedManager.managedContext)
        wallet.title = "Unit test"
        wallet.themeId = 1
        wallet.changeDate = Date()
        wallet.currencyCode = "USD"
    
        self.wallet = wallet
        view = MockView()
        router = Router(navigationController: UINavigationController(), assemblyBuilder: AssemblyBuilder())
        presenter = EditWalletPresenter(router: router, view: view, wallet: wallet, delegate: nil)
    }

    override func tearDownWithError() throws {
        CoreDataManager.sharedManager.cancelChanges()
        view = nil
        router = nil
        presenter = nil
        wallet = nil
    }

    func testViewTitle() throws {
        XCTAssertEqual(presenter.viewTitle, EditWalletViewType.edit.rawValue)
    }
    
    func testWalletTitle() throws {
        XCTAssertEqual(presenter.title, wallet.title)
    }
    
    func testWalletCurrency() throws {
        XCTAssertEqual(presenter.currency.code, "USD")
    }
    
    func testCanDeleteWallet() throws {
        XCTAssertTrue(presenter.canDelete)
    }
    
    func testExample() throws {
        
    }
}
