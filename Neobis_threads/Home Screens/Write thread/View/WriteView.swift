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
    
//    var placeholderText = "Start a thread..."
    var lineHeight: CGFloat = 41
    var textHeight: CGFloat = 18 {
        didSet {
            threadTextView.snp.updateConstraints { make in
                make.height.equalTo(flexibleHeight(to: CGFloat(textHeight)))
            }
        }
    }
    var isPostbuttonEnabled: Bool = true
    var threadText: String?
//    var third: UIAction!
    
    private var threadTextViewHeightConstraint: Constraint?
    
    lazy var menu = UIMenu(title: "", children: elements)
    lazy var first = UIAction(title: "Mentioned only", image: UIImage(named: "MentionedIcon"), identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { action in self.handleFirstAction() }
    lazy var second = UIAction(title: "Profiles you follow", image: UIImage(named: "FollowedProfilesIcon"), identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { action in self.handleSecondAction() }
    lazy var third = UIAction(title: "Anyone", image: UIImage(named: "AnyoneIcon"), identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { action in self.handleThirdAction() }
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        
        return scrollView
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
        textView.textContainerInset = .zero
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 8)
        
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
//        button.setTitleColor(UIColor(named: "PostBlue"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
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
//        threadTextView.text = placeholderText
//        threadTextView.textColor = .gray
        threadTextView.delegate = self
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
//        third = UIAction(title: "Anyone", image: UIImage(named: "AnyoneIcon"), identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { [weak self] action in
//            self?.handleThirdAction()
//        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        
        addSubview(titleLabel)
        addSubview(symbolCountLabel)
        addSubview(dividerLine)
        addSubview(scrollView)
        scrollView.addSubview(avatarImage)
        scrollView.addSubview(usernameLabel)
        scrollView.addSubview(threadTextView)
        scrollView.addSubview(stickButton)
        scrollView.addSubview(connectingLine)
        scrollView.addSubview(postImage)
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
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 134))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(replyButton.snp.top)
        }
        
        avatarImage.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 13.5))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 343.5))
            make.height.width.equalTo(flexibleHeight(to: 36))
        }
        
        usernameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 68))
            make.height.equalTo(flexibleHeight(to: 18))
        }
        
        threadTextView.snp.updateConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(flexibleHeight(to: 4))
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
//            make.trailing.equalToSuperview().inset(flexibleHeight(to: 269))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 53))
        }
        
        postButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 771))
            make.leading.equalToSuperview().inset(flexibleHeight(to: 337))
            make.trailing.equalToSuperview().inset(flexibleHeight(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 63))
        }
    }
    
    @objc func handleTap() {
        self.endEditing(true)
    }
}

extension WriteView: UITextViewDelegate {    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textHeight = newSize.height
        
        updateConstraints()
        
        let text = textView.text ?? ""
        
        threadText = text

        updateCharacterCount(for: text)
    }
    
    func updateCharacterCount(for text: String) {
        let characterCount = 280 - text.count

        symbolCountLabel.text = String(characterCount)
        
        if characterCount < 51 {
            symbolCountLabel.isHidden = false
        } else {
            symbolCountLabel.isHidden = true
        }
        
        if characterCount < 0 {
            symbolCountLabel.textColor = .red
            postButton.setTitleColor(UIColor(named: "PostBlue"), for: .normal)
            isPostbuttonEnabled = false
        } else {
            symbolCountLabel.textColor = UIColor(named: "GreyLabel")
            postButton.setTitleColor(.systemBlue, for: .normal)
            isPostbuttonEnabled = true
        }
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.text == placeholderText {
//            textView.text = ""
//            textView.textColor = .black
//        }
//    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = placeholderText
//            textView.textColor = .gray
//        }
//    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text else {
            return true
        }
        
//        if textView.text == placeholderText {
//            textView.text = ""
//            textView.textColor = .black
//        }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let numberOfLines = newText.components(separatedBy: CharacterSet.newlines).count
        
        let maxLines = 50
        
        if text == "\n" && numberOfLines <= maxLines {
            textView.text.append("\n")
            
            textHeight += 18
            lineHeight += 18
            
            updateConstraints()
            layoutIfNeeded()
            return false
        }
        
        if numberOfLines <= maxLines {
            let deletedNewlineCount = currentText.countOccurences(of: "\n", in: range)
            
            textHeight -= CGFloat(deletedNewlineCount) * 18
            lineHeight -= CGFloat(deletedNewlineCount) * 18
            
            updateConstraints()
            layoutIfNeeded()
            return true
        } else if text.isEmpty && numberOfLines == maxLines + 1 {
            let deletedNewlineCount = currentText.countOccurences(of: "\n", in: range)
            
            textHeight -= CGFloat(deletedNewlineCount) * 18
            lineHeight -= CGFloat(deletedNewlineCount) * 18
            
            updateConstraints()
            layoutIfNeeded()
            return true
        }
        
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func handleFirstAction() {
        replyButton.setTitle("Mentioned can reply", for: .normal)
    }
    
    func handleSecondAction() {
        replyButton.setTitle("Profile you follow can reply", for: .normal)
    }
    
    func handleThirdAction() {
        third.title = third.title == "Anyone" ? "Your Followers" : "Anyone"
        third.image = third.title == "Anyone" ? UIImage(named: "AnyoneIcon") : UIImage(named: "YourFollowersIcon")
        
        replyButton.setTitle("Your followers can reply", for: .normal)
        
        menu = UIMenu(title: "", children: [first, second, third])
    }
}
