//
//  ViewController.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    let spacing: CGFloat = 8
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension LoginViewController {
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = spacing * 2
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Bankey"
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subTitleLabel.adjustsFontSizeToFitWidth = true
        subTitleLabel.text = "Your premium source for all things banking!"
        subTitleLabel.numberOfLines = 0
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.addArrangedSubview(loginView)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}

// MARK: Action
extension LoginViewController {
    @objc func signInButtonTapped() {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("username, password never nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureErrorLabel(withMessage: "사용자 이름과 비밀번호를 입력해주세요.")
            return 
        }
        
        if username == "Koo" && password == "134682" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureErrorLabel(withMessage: "사용자 이름과 비밀번호를 확인하세요.")
        }
    }
    
    private func configureErrorLabel(withMessage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
}


