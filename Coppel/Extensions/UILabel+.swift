//
//  UILabel+.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 07/02/23.
//

import UIKit

public enum LabelStyle {
    case error
    case normal
    case description
    case title
    case subtitle
    case small
}

extension UILabel {
    
    convenience init(styleType: LabelStyle) {
        self.init()
        
        switch styleType {
        case .error:
            self.numberOfLines = 0
            self.textAlignment = .center
            self.textColor = UIColor(red: 225.0/255.0, green: 77.0/255.0, blue: 37.0/255.0, alpha: 1.0)
            self.font = self.font.withSize(Size.fontSmall)
        case .small:
            self.textColor = .systemGreen
            self.font = UIFont.boldSystemFont(ofSize: Size.fontExtraSmall)
        case .normal:
            self.textColor = .systemGreen
            self.font = UIFont.boldSystemFont(ofSize: Size.fontMedium)
        case .description:
            self.textColor = .white
            self.font = self.font.withSize(Size.fontSmall)
        case .title:
            self.textColor = .systemGreen
            self.font = UIFont.boldSystemFont(ofSize: Size.fontExtraLarge)
        case .subtitle:
            self.textColor = .systemGreen
            self.font = UIFont.boldSystemFont(ofSize: Size.fontLarge)
        }
        
    }
    
}
