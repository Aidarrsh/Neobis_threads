//
//  OTPView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 9/8/23.
//

import Foundation
import SnapKit
import UIKit
import AEOTPTextField

class OTPView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfBold(ofSize: 34)
        label.textColor = UIColor(named: "Black")
        label.text = "OTP Verification"
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 17)
        label.textColor = UIColor(named: "Grey")
        label.text = "Check your email to see the verification code"
        
        return label
    }()
    
    private lazy var codeField: UITextField = {
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
    
    let verifyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Black")
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.setTitle("Verify", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        
        return button
    }()
    
    private lazy var sendAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send again", for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        
        return button
    }()
    
    let otpTextField: AEOTPTextField = {
        let textField = AEOTPTextField()
        
        return textField
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
        addSubview(codeField)
        addSubview(verifyButton)
        addSubview(sendAgainButton)
        addSubview(otpTextField)
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
        
//        codeField.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(flexibleHeight(to: 281))
//            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
//            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
//            make.bottom.equalToSuperview().inset(flexibleHeight(to: 523))
//        }
        
        otpTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 281))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 121))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 523))
        }
        
        verifyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 393))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 411))
        }
        
        sendAgainButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 459))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 158))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 159))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 375))
        }
    }
}
