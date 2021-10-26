//
//  CurrencyPresenter.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 28.09.21.
//

import Foundation

protocol CurrencyDelegate: AnyObject{
    func currencyWasChanged()
}

protocol CurrencyPresenterProtocol {
    var numberOfItems: Int { get }
    var theme: Theme { get }
    func currency(at index: Int) -> CurrencyModel
    func getSelectedCurrencyIndex() -> Int
    func saveCurrency(code: String?)
}

class CurrencyPresenter {
    private let data: [CurrencyModel]
    private let wallet: Wallet
    weak var delegate: CurrencyDelegate?
    var router: RouterProtocol?
    
    init(router: RouterProtocol, delegate: CurrencyDelegate?, wallet: Wallet) {
        self.router = router
        self.delegate = delegate
        self.wallet = wallet
        let currencyCodes = Locale.commonISOCurrencyCodes
        data = currencyCodes.map({
            CurrencyModel(name: Locale.current.localizedString(forCurrencyCode: $0) ?? "", code: $0)
        })
    }
}

extension CurrencyPresenter: CurrencyPresenterProtocol {
    func currency(at index: Int) -> CurrencyModel {
        data[index]
    }
    
    var numberOfItems: Int {
        data.count
    }
    
    var theme: Theme {
        Theme.init(rawValue: Int(wallet.themeId)) ?? ThemeManager.defaultTheme
    }
    
    func getSelectedCurrencyIndex() -> Int {
        data.firstIndex { $0.code == wallet.currencyCode } ?? 0
    }
    
    func saveCurrency(code: String?) {
        wallet.currencyCode = code
        delegate?.currencyWasChanged()
        router?.pop()
    }
}
