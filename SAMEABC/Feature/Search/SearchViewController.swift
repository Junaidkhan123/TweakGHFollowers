//
//  ViewController.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 10/03/2025.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    // MARK: - UI Properties
    private let userNameTextField = TGFTextField()
    private let searchButton = TGFButton(backgroundColor: .systemGreen)
    
    private var searchButtonBottomConstraint: Constraint?
    
    private enum Constants {
        static let userNameTextFieldHeight: CGFloat = 50
        static let searchButtonHeight: CGFloat = 50
        static let buttonTitle = "Get Followers"
        static let keyboardPadding: CGFloat = 20
    }
    
    private enum AccessibilityIdentifier {
        static let textFieldIdentifier = "UserNameTextField"
        static let buttonIdentifier = "SearchButton"
        static let view = "SearchViewController"
    }
    
    // MARK: - Properties
    var viewModel: SearchViewModelProtocol
    // MARK: - Initializers
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        setupKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - setupViews
private extension SearchViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        view.accessibilityIdentifier = AccessibilityIdentifier.view
        setupUserNameTextField()
        setupSearchButton()
        setupAccessibilityIdentifiers()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    
    func setupUserNameTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(Constants.searchButtonHeight)
        }
    }
    
    func setupSearchButton() {
        searchButton.buttonTitle = Constants.buttonTitle
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(didTapSearchbutton), for: .touchUpInside)
        searchButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(Constants.searchButtonHeight)
            
            self.searchButtonBottomConstraint = make.bottom.equalToSuperview().inset(50).constraint
        }
    }
    
    func setupAccessibilityIdentifiers() {
        userNameTextField.accessibilityIdentifier = AccessibilityIdentifier.textFieldIdentifier
        searchButton.accessibilityIdentifier = AccessibilityIdentifier.buttonIdentifier
    }
    
    @objc
    func didTapSearchbutton() {
        guard let userName = userNameTextField.text, !userName.isEmpty else { return }
        viewModel.fetchFollowers(for: userName)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - ViewModel Binding
private extension SearchViewController {
    func bindViewModel() {
        viewModel.isLoadingCallback  = { [weak self] isLoading in
            self?.searchButton.isLoading = isLoading
        }
    }
}

private extension SearchViewController {
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
        
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.searchButtonBottomConstraint?.deactivate()
            self.searchButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardFrame.height + Constants.keyboardPadding)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
          UIView.animate(withDuration: 0.3) {
              self.searchButton.snp.removeConstraints()
              self.searchButton.snp.makeConstraints { make in
                  make.left.right.equalToSuperview().inset(24)
                  make.bottom.equalToSuperview().inset(50)
                  make.height.equalTo(Constants.searchButtonHeight)
                  
                  self.searchButtonBottomConstraint = make.bottom.equalToSuperview().inset(50).constraint
              }
              self.view.layoutIfNeeded()
          }
      }
}
