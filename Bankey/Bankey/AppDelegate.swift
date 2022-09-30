//
//  AppDelegate.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/21.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerVC = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerVC.delegate = self
        mainViewController.setStatuBar()
        window?.rootViewController = mainViewController
        
        return true
    }

}

// MARK: - LoginViewControllerDelegate
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        let hasOnboarded = LocalState.hasOnboarded
        if hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerVC)
        }
    }
}

// MARK: - OnboardingContainerVCDelegate
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

// MARK: - LogoutDelegate
extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil)
    }
}

extension UIView {
    func addSubViews(_ subViews: [UIView]) {
        subViews.forEach { addSubview($0) }
    }
}

extension UIStackView {
    func addArrangedSubViews(_ subViews: [UIView]) {
        subViews.forEach { addArrangedSubview($0) }
    }
}
