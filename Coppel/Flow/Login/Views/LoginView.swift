//
//  Login.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 06/02/23.
//

import UIKit

protocol LoginProtocol: AnyObject {
    func loginPressed(user: String, password: String)
}

class LoginView: UIView {
    
    var shouldSetupConstraints = true
    
    weak var loginProtocol: LoginProtocol?

    var backgroundImageView: UIImageView!
    var userNameTxt: UITextField!
    var passwordTxt: UITextField!
    var loginBtn: UIButton!
        
    lazy var errorLbl: UILabel! = {
        let label = UILabel(styleType: .error)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
      
    override init(frame: CGRect) {
      super.init(frame: frame)
        
        backgroundImageView = UIImageView(image: Image.login)
        backgroundImageView.contentMode = .scaleAspectFill
        self.addSubview(backgroundImageView)
        
        userNameTxt = UITextField()
        userNameTxt.placeholder = Text.username
        userNameTxt.formatUI()
        self.addSubview(userNameTxt)

        passwordTxt = UITextField()
        passwordTxt.placeholder = Text.password
        passwordTxt.formatUI()
        self.addSubview(passwordTxt)
        
        loginBtn = UIButton(type: .system)
        loginBtn.setTitle(Text.login, for: .normal)
        loginBtn.formatUI()
        loginBtn.addTarget(self, action: #selector(loginBtnPressed(_ :)), for: .touchUpInside)
        self.addSubview(loginBtn)
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    @objc func loginBtnPressed(_ sender: UIButton) {
        loginProtocol?.loginPressed(user: userNameTxt.text!, password: passwordTxt.text!)
    }
    
    public func setErrorLabel(error: String) {
        errorLbl.text = error
        self.addSubview(errorLbl)
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            errorLbl.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 16.0),
            errorLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            errorLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
      
    override func updateConstraints() {
      if(shouldSetupConstraints) {

          backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
          userNameTxt.translatesAutoresizingMaskIntoConstraints = false
          passwordTxt.translatesAutoresizingMaskIntoConstraints = false
          loginBtn.translatesAutoresizingMaskIntoConstraints = false
          let margins = self.layoutMarginsGuide
          NSLayoutConstraint.activate([
              backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
              backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
              
              userNameTxt.centerYAnchor.constraint(equalTo: self.centerYAnchor),
              userNameTxt.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32.0),
              userNameTxt.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32.0),
              userNameTxt.heightAnchor.constraint(equalToConstant: 48.0),
              
              passwordTxt.topAnchor.constraint(equalTo: userNameTxt.bottomAnchor, constant: 16.0),
              passwordTxt.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32.0),
              passwordTxt.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32.0),
              passwordTxt.heightAnchor.constraint(equalToConstant: 48.0),

              loginBtn.topAnchor.constraint(equalTo: passwordTxt.bottomAnchor, constant: 16.0),
              loginBtn.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32.0),
              loginBtn.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32.0),
              loginBtn.heightAnchor.constraint(equalToConstant: 48.0)

          ])
          shouldSetupConstraints = false
      }
      super.updateConstraints()
    }

}
