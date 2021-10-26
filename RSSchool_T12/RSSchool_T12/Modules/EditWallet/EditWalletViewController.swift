//
//  EditWalletViewController.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 25.09.21.
//

import UIKit

class EditWalletViewController: UIViewController {
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var walletTitleLabel: UILabel!
    @IBOutlet weak var colorThemeLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var selectedCurrencyLabel: UILabel!
    @IBOutlet weak var titleTextField: RoundedTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var themeImageView: UIImageView!
    
    var presenter: EditWalletPresenterProtocol!
    
    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.contents = ThemeManager().getBackgroundImage(theme: presenter.theme).cgImage
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 2.16, b: 0, c: 0, d: 1, tx: -0.58, ty: 0))
        layer.bounds = view.bounds
        layer.position = view.center
        return layer
    }()
    
    private let backButton: RoundButton = {
        let button = RoundButton(type: .back)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: RoundButton = {
        let button = RoundButton(type: .delete)
        button.addTarget(self, action: #selector(deleteWalltet), for: .touchUpInside)
        button.isHidden = !presenter.canDelete
        return button
    }()
    
    private lazy var navigationBar: GlassView = {
        let view = NavigationBarBuilder()
            .setLeftButton(backButton)
            .setRightButton(deleteButton)
            .setViewTitle(presenter.viewTitle)
            .build()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        subscribeOnKeyboardEvents()
        setCurrency(code: presenter.currency.code)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.contentInset.bottom = 0
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: EditWalletVieWProtocol
extension EditWalletViewController: EditWalletVieWProtocol {
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "Save changes?", preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [weak self] _ in
            self?.presenter.save(newTitle: self?.titleTextField.text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.presenter.discardChanges()
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setTheme(_ theme: Theme) {
        themeImageView.image = theme.backgroundImage
        backgroundLayer.contents = theme.backgroundImage.cgImage
    }
    
    func setCurrency(code: String) {
        selectedCurrencyLabel.text = code
    }
}

//MARK: private interface EditWalletViewController
private extension EditWalletViewController {
    @IBAction func selectColorTheme(_ sender: Any) {
        presenter.selectTheme()
    }
    
    @IBAction func selectCurrency(_ sender: Any) {
        presenter.selectCurrency()
    }
    
    @objc func backButtonTapped() {
        presenter.back()
    }
    
    
    @objc func deleteWalltet() {
        presenter.deleteWallet()
    }
    
    func setupAppearance() {
        view.layer.insertSublayer(backgroundLayer, at: 0)
        walletTitleLabel.font = .montserrat(.semiBold, 24)
        colorThemeLabel.font = .montserrat(.semiBold, 24)
        themeImageView.image = presenter.theme.backgroundImage
        currencyLabel.font = .montserrat(.semiBold, 24)
        selectedCurrencyLabel.font = .montserrat(.semiBold, 24)
        titleTextField.font = .montserrat(.semiBold, 24)
        titleTextField.delegate = self
        titleTextField.text = presenter.title
        navigationView.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: navigationView.topAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor)
        ])
    }
}

//MARK: Keyboard
private extension EditWalletViewController {
    func subscribeOnKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
}

//MARK: UITextFieldDelegate
extension EditWalletViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.changeTitle(textField.text ?? "")
    }
}
