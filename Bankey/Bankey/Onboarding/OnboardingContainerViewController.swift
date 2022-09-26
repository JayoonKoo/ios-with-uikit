//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/25.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    let pageViewController: UIPageViewController
    
    let closeButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    
    var pages: [UIViewController] = []
    var currentVC: UIViewController
    
    var currentIndex: Int = 0
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(
            imageName: "delorean",
            text: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")
        let page2 = OnboardingViewController(
            imageName: "world",
            text: "Move your money around the world quickly and securely.")
        let page3 = OnboardingViewController(
            imageName: "thumbs",
            text: "Learn more at www.bankey.com.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        // CloseButton
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        //BackButton
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.addTarget(self, action: #selector(prevTapped), for: .primaryActionTriggered)
        //nextButton
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        //doneButton
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
        setButtonVisible(fromIndex: 0)
    }
    
    private func layout() {
        view.addSubview(closeButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        view.addSubview(doneButton)
        
        // CloseButton
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        
        // BackButton
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 5)
        ])
        
        // NextButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 5)
        ])
        
        // DoneButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 5)
        ])
    }
    
    private func setButtonVisible(fromIndex index: Int) {
        backButton.isHidden = true
        nextButton.isHidden = true
        doneButton.isHidden = true
        if index == 0 {
            nextButton.isHidden = false
        } else if index == pages.count - 1 {
            backButton.isHidden = false
            doneButton.isHidden = false
        } else {
            nextButton.isHidden = false
            backButton.isHidden = false
        }
    }
    
    private func setViewController(fromIndex index: Int, direction: UIPageViewController.NavigationDirection) {
        pageViewController.setViewControllers([pages[index]], direction: direction, animated: true)
        pageViewController.pageControl?.currentPage = index
        setButtonVisible(fromIndex: index)
        currentIndex = index
    }

}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
        
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: currentVC) ?? 0
    }
}

// MARK: -UIPageViewDelegate
extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let vc = pageViewController.viewControllers?.first else {return}
        guard let index = pages.firstIndex(of: vc) else {return}
        currentIndex = index
        setButtonVisible(fromIndex: index)
    }
}

// MARK: - Action
extension OnboardingContainerViewController {
    @objc func closeTapped() {
        delegate?.didFinishOnboarding()
    }
    @objc func nextTapped() {
        let nextIndex = currentIndex + 1
        setViewController(fromIndex: nextIndex, direction: .forward)
    }
    @objc func prevTapped() {
        let prevIndex = currentIndex - 1
        setViewController(fromIndex: prevIndex, direction: .reverse)
    }
}

extension UIPageViewController {
    var pageControl: UIPageControl? {
        for view in view.subviews {
            if view is UIPageControl {
                return view as? UIPageControl
            }
        }
    return nil
    }
}
