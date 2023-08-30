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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfBold(ofSize: 34)
        label.textColor = UIColor(named: "Black")
        label.text = "Let's sign you in"
        
        return label
    }()
    
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 17)
        label.textColor = UIColor(named: "Grey")
        label.text = "We've missed you"
        
        return label
    }()
    
    lazy var emailField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(named: "GreyTextField")
        field.layer.borderColor = UIColor(named: "GreyBorder")?.cgColor
        field.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        field.layer.borderWidth = 1
        field.placeholder = "Your email"
        field.font = UIFont.sfRegular(ofSize: 15)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }()
    
    lazy var passwordField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(named: "GreyTextField")
        field.layer.borderColor = UIColor(named: "GreyBorder")?.cgColor
        field.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        field.layer.borderWidth = 1
        field.placeholder = "Password"
        field.font = UIFont.sfRegular(ofSize: 15)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        field.rightView = passwordSecureButton
        field.rightViewMode = .always
        
        
        return field
    }()
    
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        let eyeOpenImage = UIImage(named: "eyeClosed")?.withRenderingMode(.alwaysOriginal)
        let eyeClosedImage = UIImage(named: "eye")?.withRenderingMode(.alwaysOriginal)
        button.setImage(eyeOpenImage, for: .normal)
        button.setImage(eyeClosedImage, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordSecureEntry), for: .touchUpInside)
        
        return button
    }()
    
    lazy var forgotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password ?", for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Black")
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        
        return button
    }()
    
    private lazy var lineLeft: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyBorder")
        
        return view
    }()
    
    private lazy var lineRight: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyBorder")
        
        return view
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 15)
        label.textColor = UIColor(named: "Black")
        label.text = "or"
        
        return label
    }()
    
    private lazy var loginGoogleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login with Google", for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "GreyBorder")?.cgColor
        
        
        return button
    }()
    
    private lazy var loginAppleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login with Apple", for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "GreyBorder")?.cgColor
        
        
        return button
    }()
    
    private lazy var googleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "google")
        
        return image
    }()
    
    private lazy var appleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "apple")
        
        return image
    }()
    
    private lazy var signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have account yet ?"
        label.font = UIFont.sfRegular(ofSize: 15)
        
        return label
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        button.setTitleColor(UIColor(named: "Black"), for: .normal)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(named: "ScreenBackground")
        
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
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 180))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 631))
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 229))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 235))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 603))
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 281))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 523))
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 341))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 463))
        }
        
        forgotButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 411))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 22))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 245))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 423))
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 455))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 349))
        }
        
        lineLeft.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 536))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 21))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 218))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 315))
        }
        
        lineRight.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 536))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 218))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 21))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 315))
        }
        
        orLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 527))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 190))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 190))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 307))
        }
        
        loginGoogleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 569))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 235))
        }
        
        loginAppleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 633))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 171))
        }
        
        googleIcon.snp.makeConstraints { make in
            make.top.equalTo(loginGoogleButton.snp.top).inset(flexibleHeight(to: 12))
            make.leading.equalTo(loginGoogleButton.snp.leading).inset(flexibleWidth(to: 24))
            make.trailing.equalTo(loginGoogleButton.snp.trailing).inset(flexibleWidth(to: 313))
            make.bottom.equalTo(loginGoogleButton.snp.bottom).inset(flexibleHeight(to: 12))
        }
        
        appleIcon.snp.makeConstraints { make in
            make.top.equalTo(loginAppleButton.snp.top).inset(flexibleHeight(to: 12))
            make.leading.equalTo(loginAppleButton.snp.leading).inset(flexibleWidth(to: 24))
            make.trailing.equalTo(loginAppleButton.snp.trailing).inset(flexibleWidth(to: 313))
            make.bottom.equalTo(loginAppleButton.snp.bottom).inset(flexibleHeight(to: 12))
        }
        
        signupLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 758))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 76))
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 758))
            make.leading.equalTo(signupLabel.snp.trailing).offset(-10)
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 146))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 76))
        }
    }
    
    @objc private func togglePasswordSecureEntry(sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        let imageName = passwordField.isSecureTextEntry ? "eye" : "eyeClosed"
        sender.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }

}
