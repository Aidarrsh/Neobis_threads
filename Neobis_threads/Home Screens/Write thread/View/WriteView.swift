//
//  WriteView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 21/9/23.
//

import Foundation
import UIKit
import SnapKit

class WriteView: UIView {
    
    var lineHeight = 41
    
    lazy var menu = UIMenu(title: "", children: elements)
    lazy var first = UIAction(title: "Mentioned only", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { action in
    }
    lazy var second = UIAction(title: "Profiles you follow", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { action in }
    lazy var third = UIAction(title: "Anyone", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { action in }
    lazy var elements: [UIAction] = [first, second, third]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Thread"
        label.font = UIFont.sfBold(ofSize: 20)
        
        return label
    }()
    
    private lazy var dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "UserPicture")
        image.layer.cornerRadius = 18 * UIScreen.main.bounds.height / 852
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "loading..."
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
    
    lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10 * UIScreen.main.bounds.height / 852
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var stickButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "StickIcon"), for: .normal)
        
        return button
    }()
    
    lazy var replyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Anyone can reply", for: .normal)
        button.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
        button.titleLabel?.font = UIFont.sfRegular(ofSize: 15)
        button.showsMenuAsPrimaryAction = true
        button.menu = menu
        
        return button
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(UIColor(named: "PostBlue"), for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 20)
        
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
        addSubview(dividerLine)
        addSubview(avatarImage)
        addSubview(usernameLabel)
        addSubview(threadTextField)
        addSubview(stickButton)
        addSubview(connectingLine)
        addSubview(postImage)
        addSubview(replyButton)
        addSubview(postButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 72))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 56))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 756))
        }
        
        dividerLine.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 18))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 737.5))
        }
        
        avatarImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 134))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 13.5))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 343.5))
            make.height.width.equalTo(flexibleHeight(to: 36))
        }
        
        usernameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 136))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 68))
            make.height.equalTo(flexibleHeight(to: 18))
        }
        
        threadTextField.snp.makeConstraints{ make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(flexibleHeight(to: 4))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 68))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        stickButton.snp.makeConstraints { make in
            make.top.equalTo(threadTextField.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.equalTo(threadTextField.snp.leading)
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 301))
            make.height.equalTo(flexibleHeight(to: 24))
        }
        
        connectingLine.snp.makeConstraints{ make in
            make.top.equalTo(avatarImage.snp.bottom).offset(flexibleHeight(to: 10))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 359))
//            make.height.equalTo(flexibleWidth(to: 1))
//            make.bottom.equalTo(stickButton.snp.bottom)
            make.height.equalTo(flexibleHeight(to: CGFloat(lineHeight)))
        }
        
        postImage.snp.makeConstraints{ make in
            make.top.equalTo(threadTextField.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 68))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
//            make.height.equalTo(0)
        }
        
        replyButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 761))
            make.leading.equalToSuperview().inset(flexibleHeight(to: 16))
            make.trailing.equalToSuperview().inset(flexibleHeight(to: 269))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 53))
        }
        
        postButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 771))
            make.leading.equalToSuperview().inset(flexibleHeight(to: 337))
            make.trailing.equalToSuperview().inset(flexibleHeight(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 63))
        }
    }
}
