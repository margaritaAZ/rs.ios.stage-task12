//
//  EditTrancactionPresenterTest.swift
//  RSSchool_T12Tests
//
//  Created by Маргарита Жучик on 10.10.21.
//

import XCTest
@testable import RSSchool_T12

class EditTrancactionPresenterTest: XCTestCase {
    var presenter: EditTransactionPresenterProtocol!
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
        presenter = EditTransactionPresenter(router: router, transaction: transaction, wallet: wallet, delegate: nil)
    }

    override func tearDownWithError() throws {
        CoreDataManager.sharedManager.cancelChanges()
        router = nil
        presenter = nil
        transaction = nil
    }

    func testViewTitle() throws {
        XCTAssertEqual(presenter.viewTitle, "Edit transaction")
    }

}
