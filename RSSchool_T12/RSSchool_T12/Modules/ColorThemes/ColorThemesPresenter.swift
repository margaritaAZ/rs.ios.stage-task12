//
//  ColorThemesPresenter.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 27.09.21.
//

import Foundation

protocol ThemeDelegate: AnyObject {
    func selectedTheme(_ theme: Theme)
}

protocol ThemesPresesenterProtocol {
    var numberOfItems: Int { get }
    var selectedThemeId: Int { get }
    func theme(at index: Int) -> Theme
    func saveTheme(_ theme: Theme)
}

class ThemesPresenter {
    private let data: [Theme]
    private var selectedTheme: Theme
    weak var delegate: ThemeDelegate?
    var router: RouterProtocol?
    
    init(router: RouterProtocol, delegate: ThemeDelegate?, currentTheme: Theme) {
        self.router = router
        self.delegate = delegate
        data = Theme.allCases
        selectedTheme = currentTheme
    }
}

extension ThemesPresenter: ThemesPresesenterProtocol {
    var numberOfItems: Int { data.count }
    var selectedThemeId: Int { selectedTheme.rawValue }
    
    func theme(at index: Int) -> Theme {
        data[index]
    }
    
    func saveTheme(_ theme: Theme) {
        selectedTheme = theme
        delegate?.selectedTheme(selectedTheme)
        router?.pop()
    }
}
