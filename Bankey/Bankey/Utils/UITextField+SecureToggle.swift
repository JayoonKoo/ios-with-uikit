//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by 구자윤 on 2022/10/01.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    func enablePasswordToggle() {
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    // TODO: toggle 할때 전체 다 지워지는것 수정하기
    @objc func togglePasswordView(_ sender: UIButton) {
        sender.isSelected.toggle()
        isSecureTextEntry.toggle()
    }
}
