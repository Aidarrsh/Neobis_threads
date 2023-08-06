//
//  LoginView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 2/8/23.
//

import Foundation
import SnapKit
import UIKit

class LoginView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        label.textColor = UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1)
        label.text = "Let's sign you in"
        
        return label
    }()
    
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        label.textColor = UIColor(red: 0.547, green: 0.547, blue: 0.547, alpha: 1)
        label.text = "We've missed you"
        
        return label
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        field.layer.borderColor = UIColor(red: 0.749, green: 0.761, blue: 0.769, alpha: 1).cgColor
        field.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        field.layer.borderWidth = 1
        field.placeholder = "Your email"
        field.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        field.layer.borderColor = UIColor(red: 0.749, green: 0.761, blue: 0.769, alpha: 1).cgColor
        field.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        field.layer.borderWidth = 1
        field.placeholder = "Password"
        field.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password ?", for: .normal)
        button.setTitleColor(UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 15)
        
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 15)
        
        return button
    }()
    
    private let lineLeft: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.749, green: 0.761, blue: 0.769, alpha: 1)
        
        return view
    }()
    
    private let lineRight: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.749, green: 0.761, blue: 0.769, alpha: 1)
        
        return view
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        label.textColor = UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1)
        label.text = "or"
        
        return label
    }()
    
    private let loginGoogleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login with Google", for: .normal)
        button.setTitleColor(UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 15)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.749, green: 0.761, blue: 0.769, alpha: 1).cgColor
        
        
        return button
    }()
    
    private let loginAppleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login with Apple", for: .normal)
        button.setTitleColor(UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 15)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.749, green: 0.761, blue: 0.769, alpha: 1).cgColor
        
        
        return button
    }()
    
    private let googleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "google")
        
        return image
    }()
    
    private let appleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "apple")
        
        return image
    }()
    
    private let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have account yet ?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        
        return label
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 15)
        button.setTitleColor(UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1), for: .normal)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(forgotButton)
        addSubview(loginButton)
        addSubview(lineLeft)
        addSubview(lineRight)
        addSubview(orLabel)
        addSubview(loginGoogleButton)
        addSubview(loginAppleButton)
        addSubview(googleIcon)
        addSubview(appleIcon)
        addSubview(signupLabel)
        addSubview(signupButton)
    }
    
    func setupConstraints(){
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(180 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(107 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(631 * UIScreen.main.bounds.height / 852)
        }
        
        subTitleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(229 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(235 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(603 * UIScreen.main.bounds.height / 852)
        }
        
        emailField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(281 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(523 * UIScreen.main.bounds.height / 852)
        }
        
        passwordField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(341 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(463 * UIScreen.main.bounds.height / 852)
        }
        
        forgotButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(411 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(22 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(245 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(423 * UIScreen.main.bounds.height / 852)
        }
        
        loginButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(455 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(349 * UIScreen.main.bounds.height / 852)
        }
        
        lineLeft.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(536 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(21 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(218 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(315 * UIScreen.main.bounds.height / 852)
        }
        
        lineRight.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(536 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(218 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(21 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(315 * UIScreen.main.bounds.height / 852)
        }
        
        orLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(527 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(190 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(190 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(307 * UIScreen.main.bounds.height / 852)
        }
        
        loginGoogleButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(569 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(235 * UIScreen.main.bounds.height / 852)
        }
        
        loginAppleButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(633 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(171 * UIScreen.main.bounds.height / 852)
        }
        
        googleIcon.snp.makeConstraints{ make in
            make.top.equalTo(loginGoogleButton.snp.top).inset(12 * UIScreen.main.bounds.height / 852)
            make.leading.equalTo(loginGoogleButton.snp.leading).inset(24 * UIScreen.main.bounds.width / 393)
            make.trailing.equalTo(loginGoogleButton.snp.trailing).inset(313 * UIScreen.main.bounds.width / 393)
            make.bottom.equalTo(loginGoogleButton.snp.bottom).inset(12 * UIScreen.main.bounds.height / 852)
        }
        
        appleIcon.snp.makeConstraints{ make in
            make.top.equalTo(loginAppleButton.snp.top).inset(12 * UIScreen.main.bounds.height / 852)
            make.leading.equalTo(loginAppleButton.snp.leading).inset(24 * UIScreen.main.bounds.width / 393)
            make.trailing.equalTo(loginAppleButton.snp.trailing).inset(313 * UIScreen.main.bounds.width / 393)
            make.bottom.equalTo(loginAppleButton.snp.bottom).inset(12 * UIScreen.main.bounds.height / 852)
        }
        
        signupLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(758 * UIScreen.main.bounds.height / 852)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
//            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(76 * UIScreen.main.bounds.height / 852)
        }
        
        signupButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(758 * UIScreen.main.bounds.height / 852)
            make.leading.equalTo(signupLabel.snp.trailing).offset(-10)
            make.trailing.equalToSuperview().inset(146 * UIScreen.main.bounds.width / 393)
            make.bottom.equalToSuperview().inset(76 * UIScreen.main.bounds.height / 852)
        }
    }
}
