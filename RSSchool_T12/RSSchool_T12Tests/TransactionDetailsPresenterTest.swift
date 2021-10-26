//
//  TransactionDetailsPresenterTest.swift
//  RSSchool_T12Tests
//
//  Created by Маргарита Жучик on 10.10.21.
//

import XCTest
@testable import RSSchool_T12

class TransactionDetailsPresenterTest: XCTestCase {
    var presenter: TransactionDetailsPresenterProtocol!
    var router: RouterProtocol!
    var transaction: Transaction!

    override func setUpWithError() throws {
        let wallet = Wallet(context: CoreDataManager.sharedManager.managedContext)
        transaction = Transaction(context: CoreDataManager.sharedManager.managedContext)
        transaction.wallet = wallet
        transaction.note = "Note"
        transaction.creationDate = Date()
        transaction.title = "Transaction"
        transaction.value = 10
        router = Router(navigationController: UINavigationController(), assemblyBuilder: AssemblyBuilder())
        presenter = TransactionDetailsPresenter(router: router, transaction: transaction, wallet: wallet, delegate: nil)
    }

    override func tearDownWithError() throws {
        CoreDataManager.sharedManager.cancelChanges()
        router = nil
        presenter = nil
        transaction = nil
    }

    func testViewTitle() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        XCTAssertEqual(presenter.viewTitle, dateFormatter.string(from: Date()))
    }
    
    func testTheme() throws {
        XCTAssertEqual(ThemeManager.defaultTheme, presenter.theme)
    }
    
    func testTransactionTitle() throws {
        XCTAssertEqual(presenter.title, "Transaction")
    }
    
    func testChange() throws {
        XCTAssertEqual(presenter.change, "10.0")
    }
    
    func testNote() throws {
        XCTAssertEqual(presenter.note, "Note")
    }

}
