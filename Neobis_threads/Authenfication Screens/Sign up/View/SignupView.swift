//
//  SignupView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 11/8/23.
//

import Foundation
import SnapKit
import UIKit

class SignupView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfBold(ofSize: 34)
        label.textColor = UIColor(named: "Black")
        label.text = "Create an account"
        
        return label
    }()
    
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 17)
        label.textColor = UIColor(named: "Grey")
        label.text = "Create account to start using Threads"
        
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
    
    lazy var nameField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(named: "GreyTextField")
        field.layer.borderColor = UIColor(named: "GreyBorder")?.cgColor
        field.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        field.layer.borderWidth = 1
        field.placeholder = "Your name"
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
    
    lazy var confirmPasswordField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(named: "GreyTextField")
        field.layer.borderColor = UIColor(named: "GreyBorder")?.cgColor
        field.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        field.layer.borderWidth = 1
        field.placeholder = "Confirm password"
        field.font = UIFont.sfRegular(ofSize: 15)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        field.rightView = passwordConfirmSecureButton
        field.rightViewMode = .always
        
        return field
    }()
    
    private lazy var passwordConfirmSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        let eyeOpenImage = UIImage(named: "eyeClosed")?.withRenderingMode(.alwaysOriginal)
        let eyeClosedImage = UIImage(named: "eye")?.withRenderingMode(.alwaysOriginal)
        button.setImage(eyeOpenImage, for: .normal)
        button.setImage(eyeClosedImage, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(toggleConfirmPasswordSecureEntry), for: .touchUpInside)
        
        return button
    }()
    
    lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Black")
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.setTitle("Create account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        
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
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(emailField)
        addSubview(nameField)
        addSubview(passwordField)
        addSubview(confirmPasswordField)
        addSubview(createAccountButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 180))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 67))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 631))
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 229))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 603))
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 281))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 523))
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 347))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 457))
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 411))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 393))
        }
        
        confirmPasswordField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 475))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 329))
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 587))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 217))
        }
    }
    
    @objc private func togglePasswordSecureEntry(sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        let imageName = passwordField.isSecureTextEntry ? "eye" : "eyeClosed"
        sender.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @objc private func toggleConfirmPasswordSecureEntry(sender: UIButton) {
        confirmPasswordField.isSecureTextEntry.toggle()
        let imageName = confirmPasswordField.isSecureTextEntry ? "eye" : "eyeClosed"
        sender.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
}
