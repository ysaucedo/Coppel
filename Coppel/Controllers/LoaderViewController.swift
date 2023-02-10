//
//  LoaderViewController.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 07/02/23.
//

import UIKit

class LoaderViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView!
    var waitLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.alpha = Size.percentTransparency
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        waitLbl = UILabel()
        waitLbl.text = Text.wait
        view.addSubview(waitLbl)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        waitLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            waitLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waitLbl.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16.0)
            
        ])
                
    }

}
