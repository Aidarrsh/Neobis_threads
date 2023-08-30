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
    
    init(signUpProtocol: SignUpProtocol) {
        self.signUpProtocol = signUpProtocol
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
        
        guard let email = contentView.emailField.text,
              let username = contentView.nameField.text,
              let password = contentView.passwordField.text,
              let password2 = contentView.confirmPasswordField.text else {
            print("Email or password is empty.")
            return
        }
        
        signUpProtocol.register(email: email, username: username, password: password, password2: password2)
        print(email, username, password, password2)
        
        if signUpProtocol.isRegistered == true {
            let vc = PasswordViewController()
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
