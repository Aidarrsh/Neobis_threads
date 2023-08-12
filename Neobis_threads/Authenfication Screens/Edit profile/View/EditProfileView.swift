//
//  EditProfileView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import Foundation
import SnapKit
import UIKit

class EditProfileView: UIView {
    
    private lazy var profilePicture: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "UserPicture")
        image.backgroundColor = UIColor(named: "GreyButtonBorder")
        image.layer.cornerRadius = 35 * UIScreen.main.bounds.height / 852
        
        return image
    }()
    
    private lazy var editPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit photo", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 14)
        
        return button
    }()
    
    private lazy var sectionView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(named: "GreyLabel")?.cgColor
        view.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        view.layer.borderWidth = 1
        
        return view
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.sfSemiBold(ofSize: 14)
        
        return label
    }()
    
    private lazy var usernameTextField: BorderedTextField = {
        let field = BorderedTextField()
        
        return field
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.sfSemiBold(ofSize: 14)
        
        return label
    }()
    
    private lazy var nameTextField: BorderedTextField = {
        let field = BorderedTextField()
        
        return field
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio"
        label.font = UIFont.sfSemiBold(ofSize: 14)
        
        return label
    }()
    
    private lazy var bioTextField: BorderedTextField = {
        let field = BorderedTextField()
        field.placeholder = "+ Write bio"
        
        return field
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.text = "Link"
        label.font = UIFont.sfSemiBold(ofSize: 14)
        
        return label
    }()
    
    private lazy var linkTextField: BorderedTextField = {
        let field = BorderedTextField()
        field.placeholder = "+ Write link"
        
        return field
    }()
    
    private lazy var privateProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "Private profile"
        label.font = UIFont.sfSemiBold(ofSize: 14)
        
        return label
    }()
    
    private lazy var toggleProfilePrivat: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .black
        
        return toggle
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
        addSubview(profilePicture)
        addSubview(editPhotoButton)
        addSubview(sectionView)
        addSubview(usernameLabel)
        addSubview(usernameTextField)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(bioLabel)
        addSubview(bioTextField)
        addSubview(linkLabel)
        addSubview(linkTextField)
        addSubview(privateProfileLabel)
        addSubview(toggleProfilePrivat)
    }
    
    func setupConstraints() {
        profilePicture.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 196))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 161))
            make.height.equalTo(flexibleHeight(to: 70))
            make.width.equalTo(flexibleHeight(to: 70))
        }
        
        editPhotoButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 282))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 165))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 165))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 552))
        }
        
        sectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 365))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 120))
        }
        
        usernameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 385))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 297))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 449))
        }
        
        usernameTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 403))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 32))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 411))
        }
        
        nameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 453))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 324))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 381))
        }
        
        nameTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 471))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 32))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 343))
        }
        
        bioLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 521))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 324))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 313))
        }
        
        bioTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 539))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 32))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 275))
        }
        
        linkLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 589))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 324))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 245))
        }
        
        linkTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 607))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 32))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 207))
        }
        
        privateProfileLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 688))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 276))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 146))
        }
        
        toggleProfilePrivat.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 681))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 310))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 32))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 140))
        }
    }
}
