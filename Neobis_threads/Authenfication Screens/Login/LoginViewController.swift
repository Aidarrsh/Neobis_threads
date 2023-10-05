//
//  ViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 2/8/23.
//

import UIKit
import SnapKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    private let contentView = LoginView()
    var loginProtocol: LoginProtocol!
    
    init(loginProtocol: LoginProtocol) {
        self.loginProtocol = loginProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addTargets()
    }
    
    func setupView(){
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.forgotButton.addTarget(self, action: #selector(forgotButtonTapped), for: .touchUpInside)
        contentView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        contentView.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        contentView.loginGoogleButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
    }
    
    @objc func forgotButtonTapped() {
        let vc = ForgotViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signupButtonTapped() {
        let vc = SignupViewController(signUpProtocol: SignUpViewModel(), signUpConfirmProtocol: SignupConfirmEmailViewModel())
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButton() {
        guard let name = contentView.emailField.text?.lowercased(), let password = contentView.passwordField.text else {
            return
        }
        
        loginProtocol.login(email: name, password: password)
        
        loginProtocol.loginResult = { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = UINavigationController(rootViewController: TabBarController())
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print("Login failed with error: \(error)")
                
                self?.showErrorAlert(message: "Введены неверные данные. Попробуйте еще раз.")
            }
        }
    }
    
    @objc func googleButtonPressed() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }

            
        }
    }

    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Неверные данные", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

