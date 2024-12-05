//
//  UITextView+SecureToggle.swift
//  Bankey
//
//  Created by Huy Ton Anh on 05/12/2024.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle() {
        
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordVisibility(_ sender: Any) {
        self.isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
