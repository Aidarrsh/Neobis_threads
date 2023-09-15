//
//  SignupViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 11/8/23.
//

import SnapKit
import UIKit

class SignupViewController: UIViewController {
    
    private let contentView = SignupView()
    var signUpProtocol: SignUpProtocol!
    var signUpConfirmProtocol: SignupConfirmProtocol!
    
    init(signUpProtocol: SignUpProtocol, signUpConfirmProtocol: SignupConfirmProtocol) {
        self.signUpProtocol = signUpProtocol
        self.signUpConfirmProtocol = signUpConfirmProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        setupView()
    }
    
    func addTargets() {
        contentView.createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
    func setupView() {
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func createAccountButtonTapped() {
        
        guard let email = contentView.emailField.text?.lowercased(),
              let username = contentView.nameField.text,
              let password = contentView.passwordField.text,
              let password2 = contentView.confirmPasswordField.text else {
            print("Email or password is empty.")
            return
        }
        
        signUpProtocol.register(email: email, username: username, password: password, password2: password2)
        
        if email.isEmpty {
            self.showErrorAlert(message: "Требуется почта")
        }
        
        if !email.contains("@") {
            self.showErrorAlert(message: "Неверный формат почты")
        }
        
        if username.isEmpty {
            self.showErrorAlert(message: "Требуется никнейм")
        }
        
        if password != password2 {
            self.showErrorAlert(message: "Пароли не совпадают")
        }
        
        if !email.isEmpty && email.contains("@") && !username.isEmpty && password == password2 {
            signUpProtocol.registerResult = { [weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        let vc = OTPViewController(otpProtocol: OTPViewModel(), email: email)
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                case .failure(let error):
                    print("Register failed with error: \(error)")
                    
                    // Show an alert with the error message
                    self?.showErrorAlert(message: "Этот никнейм уже занят.")
                }
            }
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Неверные данные", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
