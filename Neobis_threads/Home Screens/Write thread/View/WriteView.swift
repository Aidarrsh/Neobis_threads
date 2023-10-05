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
    
    var lineHeight: CGFloat = 41
    var textHeight: CGFloat = 34 {
        didSet {
            threadTextView.snp.updateConstraints { make in
                make.height.equalTo(flexibleHeight(to: CGFloat(textHeight)))
            }
        }
    }
    
    private var threadTextViewHeightConstraint: Constraint?
    
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
    
    lazy var symbolCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "GreyLabel")
        label.isHidden = true
        
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
    
    lazy var threadTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.sfRegular(ofSize: 15)
        textView.isScrollEnabled = false
        
        return textView
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
        threadTextView.delegate = self
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(symbolCountLabel)
        addSubview(dividerLine)
        addSubview(avatarImage)
        addSubview(usernameLabel)
        addSubview(threadTextView)
        addSubview(stickButton)
        addSubview(connectingLine)
        addSubview(postImage)
        addSubview(replyButton)
        addSubview(postButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 55))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 56))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 756))
        }
        
        symbolCountLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(flexibleWidth(to: 765))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
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
        
        threadTextView.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(flexibleHeight(to: 158))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 68))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            threadTextViewHeightConstraint = make.height.equalTo(flexibleHeight(to: CGFloat(textHeight))).constraint
        }
        
        stickButton.snp.makeConstraints { make in
            make.top.equalTo(threadTextView.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.equalTo(threadTextView.snp.leading)
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 301))
            make.height.equalTo(flexibleHeight(to: 24))
        }
        
        connectingLine.snp.updateConstraints{ make in
            make.top.equalTo(avatarImage.snp.bottom).offset(flexibleHeight(to: 10))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 359))
//            make.height.equalTo(flexibleWidth(to: 1))
//            make.bottom.equalTo(stickButton.snp.bottom)
            make.height.equalTo(flexibleHeight(to: CGFloat(lineHeight)))
        }
        
        postImage.snp.makeConstraints{ make in
            make.top.equalTo(threadTextView.snp.bottom).offset(flexibleHeight(to: 20))
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

extension WriteView: UITextViewDelegate {    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textHeight = newSize.height
        updateConstraints()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text else {
            return true
        }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let numberOfLines = newText.components(separatedBy: CharacterSet.newlines).count
        
        let maxLines = 15
        
        if text == "\n" && numberOfLines <= maxLines {
            textView.text.append("\n")
            
            textHeight += 15
            
            updateConstraints()
            layoutIfNeeded()
            return false
        }
        
        if numberOfLines <= maxLines {
            let deletedNewlineCount = currentText.countOccurences(of: "\n", in: range)
            
            textHeight -= CGFloat(deletedNewlineCount) * 15
            
            updateConstraints()
            layoutIfNeeded()
            return true
        } else if text.isEmpty && numberOfLines == maxLines + 1 {
            let deletedNewlineCount = currentText.countOccurences(of: "\n", in: range)
            
            textHeight -= CGFloat(deletedNewlineCount) * 15
            
            updateConstraints()
            layoutIfNeeded()
            return true
        }
        
        return false
    }
}
