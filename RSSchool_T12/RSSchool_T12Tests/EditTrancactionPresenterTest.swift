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
    let coreDataManager: CoreDataManagerProtocol = TestCoreDataManager()

    override func setUpWithError() throws {
        let wallet = Wallet(context: coreDataManager.managedContext)
        transaction = Transaction(context: coreDataManager.managedContext)
        transaction.wallet = wallet
        transaction.note = "Note"
        transaction.creationDate = Date()
        transaction.title = "Transaction"
        transaction.value = 10
        router = Router(navigationController: UINavigationController(), assemblyBuilder: AssemblyBuilder())
        presenter = EditTransactionPresenter(router: router, transaction: transaction, wallet: wallet, delegate: nil, coreDataManager: coreDataManager)
    }

    override func tearDownWithError() throws {
        coreDataManager.cancelChanges()
        router = nil
        presenter = nil
        transaction = nil
    }

    func testViewTitle() throws {
        XCTAssertEqual(presenter.viewTitle, "Edit transaction")
    }

}
