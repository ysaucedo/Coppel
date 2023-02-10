//
//  LoginViewModel.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 07/02/23.
//

import UIKit

final class LoginViewModel {
    
    func login(user: String , password: String, completion: @escaping RequestCompletion<LoginResponse>) {
        #warning("Must call a webservice to perform a real login")
        
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            if self.validateUser(user: user, password: password) {
                
                let defaults = UserDefaults.standard
                defaults.set(user, forKey: Constant.userNameKey)
                
                let data = """
                {
                    "success": true
                }
                """.data(using: .utf8)!
                if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                    completion(.success(response: loginResponse))
                }
            } else {
                completion(.failure(error: NSError(domain: Text.messageLoginError, code: 404)))
            }
        }

    }
    
    private func validateUser(user: String, password: String) -> Bool {

        return (user == "Yair" && password == "Pass") ? true : false

    }
    
    func instanciateLoader() -> UIViewController {
        let vc = LoaderViewController()
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
    func instanciateMovies() -> UIViewController {
        let vc = MoviesViewController()
        vc.modalPresentationStyle = .automatic
        return vc
    }
    
}
