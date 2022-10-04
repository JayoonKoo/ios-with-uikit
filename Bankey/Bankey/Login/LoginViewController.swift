//
//  ViewController.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/21.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var titleLeadingConstraint: NSLayoutConstraint?
    var subTitleLeadingConstraint: NSLayoutConstraint?
    
    let viewInLeading: CGFloat = 16
    let viewOutLeading: CGFloat = -1000
    
    let spacing: CGFloat = 8
    
    weak var delegate: LoginViewControllerDelegate?
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animation()
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
        titleLabel.alpha = 0
        
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
        view.addSubViews([titleLabel, subTitleLabel, stackView])
        stackView.addArrangedSubViews([loginView, signInButton, errorMessageLabel])
        
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2)
        ])
        titleLeadingConstraint = titleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: viewOutLeading)
        titleLeadingConstraint?.isActive = true
        
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: subTitleLabel.trailingAnchor, multiplier: 2),
        ])
        subTitleLeadingConstraint = subTitleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: viewOutLeading)
        subTitleLeadingConstraint?.isActive = true

        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: subTitleLabel.bottomAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
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
            delegate?.didLogin()
        } else {
            configureErrorLabel(withMessage: "사용자 이름과 비밀번호를 확인하세요.")
        }
    }
    
    private func configureErrorLabel(withMessage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
        shakeSignInButton()
    }
}

// MARK: Animation
extension LoginViewController {
    func animation() {
        let duration = 1.0
        let animation1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingConstraint?.constant = self.viewInLeading
            self.view.layoutIfNeeded()
        }
        animation1.startAnimation()
        
        let animation2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subTitleLeadingConstraint?.constant = self.viewInLeading
            self.view.layoutIfNeeded()
        }
        animation2.startAnimation(afterDelay: 0.2)
        
        let animation3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animation3.startAnimation(afterDelay: 0.2)
    }
    
    func shakeSignInButton() {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.53, 0.86, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "Shake")
    }
}
