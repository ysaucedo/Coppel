//
//  LoginViewController.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 06/02/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    var login: LoginView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        login.loginProtocol = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        login.userNameTxt.becomeFirstResponder()
        login.userNameTxt.text = Constant.emptyString
        login.passwordTxt.text = Constant.emptyString
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
                
        login = LoginView()
        login.backgroundColor = .blue
        self.view.addSubview(login)
        login.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            login.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            login.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            login.topAnchor.constraint(equalTo: view.topAnchor),
            login.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }

}

extension LoginViewController: LoginProtocol {
    func loginPressed(user: String, password: String) {
        let vc = viewModel.instanciateLoader()
        present(vc, animated: false, completion: nil)
        viewModel.login(user: user, password: password, completion: { [weak self] result in
            guard let self = self else { return }
            defer { vc.dismiss(animated: false) }
            switch result {
            case .success(response: _):
                self.login.setErrorLabel(error: Constant.emptyString)
                let vc = self.viewModel.instanciateMovies()
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(error: let error):
                self.login.setErrorLabel(error: error.domain)
            }
        })
    }
}
