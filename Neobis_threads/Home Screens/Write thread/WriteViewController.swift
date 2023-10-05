//
//  WriteViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 21/9/23.
//

import UIKit
import SnapKit

class WriteViewController: UIViewController {
    private let contentView = WriteView()
    
    var writeProtocol: WriteProtocol
    var profileProtocol: ProfileProtocol
    var threadText: String?
    var image: Data?
    
    init(writeProtocol: WriteProtocol, profileProtocol: ProfileProtocol) {
        self.writeProtocol = writeProtocol
        self.profileProtocol = profileProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getUserData()
        contentView.threadTextView.delegate = self
        setupView()
        addTargets()
    }
    
    func getUserData() {
        DispatchQueue.main.async {
            self.profileProtocol.fetchUserData() { [weak self] result in
                switch result {
                case .success(let data):
                    self?.parseUserData(data)
                case .failure(let error):
                    print("Failed to fetch user data:", error)
                }
            }
        }
    }
    
    func parseUserData(_ userData: [String: Any]) {
        if let username = userData["username"] as? String {
            DispatchQueue.main.async {
                self.contentView.usernameLabel.text = username
            }
        }
        
        if let photoURLString = userData["photo"] as? String,
           let photoURL = URL(string: photoURLString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: photoURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.contentView.avatarImage.image = image
                    }
                } else {
                    print("Failed to load image from URL:", photoURL)
                }
            }
            
        }
    }
    
    func setupView() {
        
//        title = "New Thread"
        
        let backButton = UIBarButtonItem(image: UIImage(named: "CloseIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.postButton.addTarget(self, action: #selector(postPressed), for: .touchUpInside)
        contentView.stickButton.addTarget(self, action: #selector(stickPressed), for: .touchUpInside)
    }
    
    @objc func postPressed() {
        
        writeProtocol.sendThread(text: threadText ?? "", image: image ?? Data(), video: Data(), comments_permission: "anyone")
    }
    
    @objc func stickPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func backPressed() {
        dismiss(animated: true)
    }
}


extension WriteViewController: UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            contentView.postImage.image = selectedImage
            contentView.stickButton.isHidden = true
            contentView.postImage.isHidden = false
            
            let aspectRatio = selectedImage.size.width / selectedImage.size.height
            let newHeight = contentView.postImage.frame.width / aspectRatio
            
            contentView.postImage.snp.makeConstraints { make in
                make.height.equalTo(newHeight)
            }
            
//            contentView.connectingLine.snp.updateConstraints { make in
//                make.height.equalTo(200)
//            }
            
            contentView.lineHeight += newHeight

            self.updateViewConstraints()
            self.view.layoutIfNeeded()
            
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.2) else { return }
            image = imageData
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text ?? ""
        
        threadText = text

        updateCharacterCount(for: text)
    }
    
    func updateCharacterCount(for text: String) {
        let characterCount = 280 - text.count

        contentView.symbolCountLabel.text = String(characterCount)
        
        if characterCount < 51 {
            contentView.symbolCountLabel.isHidden = false
        } else {
            contentView.symbolCountLabel.isHidden = true
        }
        
        if characterCount < 0 {
            contentView.symbolCountLabel.textColor = .red
        } else {
            contentView.symbolCountLabel.textColor = UIColor(named: "GreyLabel")
        }
    }
}
