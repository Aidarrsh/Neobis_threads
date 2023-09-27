//
//  CustomWriteCell.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 21/9/23.
//

import UIKit
import SnapKit

class CustomWriteCell: UITableViewCell {
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AvatarThree")
        image.layer.cornerRadius = 18 * UIScreen.main.bounds.height / 852
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "iamnalimov"
        label.font = UIFont.sfBold(ofSize: 14)
        
        return label
    }()
    
    lazy var threadTextField: UITextField = {
        let field = UITextField()
        field.font = UIFont.sfRegular(ofSize: 15)
        field.placeholder = "Start a thread..."
        
        return field
    }()
    
    lazy var connectingLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "GreyButtonBorder")?.cgColor
        
        
        return view
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        
        return image
    }()
    
    lazy var stickButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "StickIcon"), for: .normal)
        
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if threadTextField.frame.contains(touchLocation) {
            threadTextField.becomeFirstResponder()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(avatarImage)
        addSubview(usernameLabel)
        addSubview(threadTextField)
        addSubview(stickButton)
        addSubview(connectingLine)
        addSubview(image)
    }
    
    func setupConstraints() {
        
        avatarImage.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 13.5))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 343.5))
            make.height.width.equalTo(flexibleHeight(to: 36))
        }
        
        usernameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 59.5))
            make.height.equalTo(flexibleHeight(to: 20))
        }
        
        threadTextField.snp.makeConstraints{ make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(flexibleHeight(to: 4))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 59))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 44))
        }
        
        stickButton.snp.makeConstraints { make in
            make.top.equalTo(threadTextField.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.equalTo(threadTextField.snp.leading)
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 301))
            make.height.equalTo(flexibleHeight(to: 24))
        }
        
        connectingLine.snp.makeConstraints{ make in
            make.top.equalTo(avatarImage.snp.bottom).offset(flexibleHeight(to: 8))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 359))
//            make.height.equalTo(flexibleWidth(to: 1))
            make.bottom.equalTo(stickButton.snp.bottom)
        }
        
        image.snp.makeConstraints{ make in
            make.top.equalTo(threadTextField.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 68))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
    }
}
