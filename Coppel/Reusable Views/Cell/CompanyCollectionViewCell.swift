//
//  CompanyCollectionViewCell.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import UIKit
import Kingfisher

class CompanyCollectionViewCell: UICollectionViewCell {
 
    var imageView: UIImageView!
    var titleLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = Size.cornerRadiusText
        
        self.backgroundColor = .gray
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Size.cornerRadiusText
        imageView.contentMode = .scaleAspectFit
        imageView.image = Image.login
        self.addSubview(imageView)
        
        titleLbl = UILabel(styleType: .small)
        self.addSubview(titleLbl)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: margins.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(company: Company) {
        titleLbl.text = company.name
        if let image = company.logo_path, let url = URL(string: Constant.regularImageBaseURLString + image)  {
            imageView.kf.setImage(with: url)
        } else { imageView.image = Image.posterDefault?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal) }
    }
    
}
