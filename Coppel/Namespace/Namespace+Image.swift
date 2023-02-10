//
//  Namespace+Image.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 07/02/23.
//

import UIKit.UIImage

typealias Image = Namespace.Image

extension Namespace {
    
    enum Image {
        
        static let login = UIImage(named: "backImage")
        
        static let profile = UIImage(systemName: "person.circle.fill")
        
        static let list = UIImage(systemName: "list.bullet")
        
        static let favorite = UIImage(systemName: "heart")
        
        static let star = UIImage(systemName: "star.fill")
        
        static let posterDefault = UIImage(systemName: "nosign")
        
        static let play = UIImage(systemName: "play.circle")
        
    }
    
}
