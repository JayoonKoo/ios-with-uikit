//
//  MainViewController.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/28.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let VC1 = DummyVC1()
        let VC2 = DummyVC2()
        let VC3 = DummyVC3()
        
        VC1.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        VC2.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        VC3.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let NVC1 = UINavigationController(rootViewController: VC1)
        let NVC2 = UINavigationController(rootViewController: VC2)
        let NVC3 = UINavigationController(rootViewController: VC3)
        
        viewControllers = [NVC1, NVC2, NVC3]
        
        setup()
    }
}

extension MainViewController {
    func setup() {
        setupTabBar()
    }
    
    func style() {
        
    }
    
    func layout() {
        
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}


class DummyVC1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class DummyVC2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
}
class DummyVC3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}
