//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/28.
//

import UIKit

extension UIViewController {
    func setStatuBar() {
        let navAppearnce = UINavigationBarAppearance()
        navAppearnce.configureWithTransparentBackground()
        navAppearnce.backgroundColor = appColor
        
        UINavigationBar.appearance().standardAppearance = navAppearnce
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearnce
    }
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
