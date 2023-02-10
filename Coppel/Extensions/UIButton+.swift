//
//  UIButton+.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 06/02/23.
//

import UIKit

extension UIButton {
    
    func formatUI() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = Size.cornerRadiusText
        self.tintColor = .white
    }
    
}
