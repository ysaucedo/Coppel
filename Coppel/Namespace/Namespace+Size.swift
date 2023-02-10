//
//  Namespace+Size.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 07/02/23.
//

import Foundation

typealias Size = Namespace.Constant.Size

extension Namespace.Constant {
 
    enum Size {
        
        // MARK: - Size
        static let fontExtraLarge: CGFloat = 24.0
        static let fontLarge: CGFloat = 18.0
        static let fontMedium: CGFloat = 14.0
        static let fontSmall: CGFloat = 12.0
        static let fontExtraSmall: CGFloat = 10.0

        static let cornerRadiusText: CGFloat = 6.0
        
        static let marginsTextField: CGFloat = 15.0
        
        static let spaceElementLarge: CGFloat = 20.0
        static let spaceElementMedium: CGFloat = 12.0
        static let spaceElement: CGFloat = 8.0
        static let spaceElementSmall: CGFloat = 4.0
                
        static let imageProfile: CGFloat = 100.0
        static let cornerRadiusPoster: CGFloat = 26.0
        // MARK: - Percents
        static let percentTransparency: CGFloat = 0.95
        static let posterRelation: CGFloat = 1.3
        
    }
    
    
    
}
