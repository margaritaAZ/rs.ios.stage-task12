//
//  AddWalletPresenterTest.swift
//  RSSchool_T12Tests
//
//  Created by Маргарита Жучик on 10.10.21.
//

import XCTest
@testable import RSSchool_T12

class AddWalletPresenterTest: XCTestCase {
    var presenter: EditWalletPresenter!
    var view: MockView!
    var router: RouterProtocol!
    let coreDataManager: CoreDataManagerProtocol = TestCoreDataManager()

    override func setUpWithError() throws {
        view = MockView()
        router = Router(navigationController: UINavigationController(), assemblyBuilder: AssemblyBuilder())
        presenter = EditWalletPresenter(router: router, view: view, wallet: nil, delegate: nil, coreData: coreDataManager)
    }

    override func tearDownWithError() throws {
        coreDataManager.cancelChanges()
        view = nil
        router = nil
        presenter = nil
    }
    
    func testViewTitle() throws {
        XCTAssertEqual(presenter.viewTitle, EditWalletViewType.create.rawValue)
    }
    
    func testWalletTitle() throws {
        XCTAssertNil(presenter.title)
    }
    
    func testWalletCurrency() throws {
        XCTAssertEqual(presenter.currency.code, CurrencyModel.defaultCode)
    }
    
    func testCanDeleteWallet() throws {
        XCTAssertFalse(presenter.canDelete)
    }

    func testExample() throws {
  
    }

}
