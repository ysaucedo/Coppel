//
//  VideoCollectionViewCell.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import Foundation

import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {
 
    var imageView: UIImageView!
    var playImageView: UIImageView!
    var titleLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = Size.cornerRadiusText
        
        self.backgroundColor = Color.secondary100
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Size.cornerRadiusText
        imageView.contentMode = .scaleAspectFit
        imageView.image = Image.login
        self.addSubview(imageView)
        
        playImageView = UIImageView()
        playImageView.clipsToBounds = true
        playImageView.image = Image.play?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        self.addSubview(playImageView)
        
        titleLbl = UILabel(styleType: .small)
        self.addSubview(titleLbl)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            playImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            playImageView.heightAnchor.constraint(equalTo: playImageView.widthAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(video: Video) {
        titleLbl.text = video.name
        let url = URL(string: Constant.youtubeImgBaseURLString + "/vi/" + video.key + "/hqdefault.jpg")
        imageView.kf.setImage(with: url)
    }
    
}
