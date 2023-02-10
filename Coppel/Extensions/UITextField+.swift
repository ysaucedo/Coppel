//
//  UITextField+.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 06/02/23.
//

import UIKit

extension UITextField {
    
    func formatUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = Size.cornerRadiusText
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Size.marginsTextField, height: self.frame.size.height))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: Size.marginsTextField, height: self.frame.size.height))
        self.rightViewMode = .always
    }
    
}
