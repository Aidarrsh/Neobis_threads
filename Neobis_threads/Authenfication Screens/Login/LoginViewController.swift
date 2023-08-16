//
//  ViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 2/8/23.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let contentView = LoginView()

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
    }
    
    @objc func forgotButtonTapped() {
        let vc = ForgotViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signupButtonTapped() {
        let vc = SignupViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButton() {
        let vc = TabBarController()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

