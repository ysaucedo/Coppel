//
//  MovieCollectionViewCell.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 07/02/23.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var titleLbl: UILabel!
    var dateLbl: UILabel!
    var rankingLbl: UILabel!
    var starImageView: UIImageView!
    var descriptionLbl: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = Size.cornerRadiusPoster
        
        self.backgroundColor = Color.secondary100
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Size.cornerRadiusPoster
        imageView.contentMode = .scaleAspectFill
        imageView.image = Image.login
        self.addSubview(imageView)
        
        titleLbl = UILabel(styleType: .normal)
        self.addSubview(titleLbl)
        
        dateLbl = UILabel(styleType: .normal)
        self.addSubview(dateLbl)
        
        rankingLbl = UILabel(styleType: .normal)
        self.addSubview(rankingLbl)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: Size.fontSmall)
        starImageView = UIImageView()
        starImageView.image = Image.star?.withConfiguration(configuration).withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        self.addSubview(starImageView)
        
        descriptionLbl = UILabel(styleType: .description)
        descriptionLbl.numberOfLines = 0
        self.addSubview(descriptionLbl)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        rankingLbl.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: Size.posterRelation),
            
            titleLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Size.spaceElement),
            titleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            dateLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: Size.spaceElementMedium),
            dateLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),

            rankingLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: Size.spaceElementMedium),
            rankingLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            starImageView.trailingAnchor.constraint(equalTo: rankingLbl.leadingAnchor, constant: -Size.spaceElementSmall),
            starImageView.centerYAnchor.constraint(equalTo: rankingLbl.centerYAnchor),
            
            descriptionLbl.topAnchor.constraint(equalTo: dateLbl.bottomAnchor, constant: Size.spaceElementMedium),
            descriptionLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            descriptionLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            descriptionLbl.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            
        ])

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(show: Show) {
        titleLbl.text = show.name
        dateLbl.text = show.first_air_date
        rankingLbl.text = String(show.vote_average)
        descriptionLbl.text = show.overview
        if let poster = show.poster_path, let url = URL(string: Constant.regularImageBaseURLString + poster)  {
            imageView.kf.setImage(with: url)
        } else { imageView.image = Image.posterDefault?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal) }
    }
    
}
