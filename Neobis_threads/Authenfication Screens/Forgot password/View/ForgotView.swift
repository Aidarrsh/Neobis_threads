//
//  ForgotView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 8/8/23.
//

import Foundation
import SnapKit
import UIKit

class ForgotView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfBold(ofSize: 34)
        label.textColor = UIColor(named: "Black")
        label.text = "Forgot password ?"
        
        return label
    }()
    
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 17)
        label.textColor = UIColor(named: "Grey")
        label.text = "Enter your email address to reset password"
        
        return label
    }()
    
    private lazy var emailField: UITextField = {
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
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Black")
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.setTitle("Continue", for: .normal)
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
        addSubview(continueButton)
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
        
        continueButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 393))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 411))
        }
    }
}
