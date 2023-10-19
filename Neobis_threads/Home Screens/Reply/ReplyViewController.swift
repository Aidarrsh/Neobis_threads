//
//  ReplyViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 21/8/23.
//

import UIKit
import SnapKit

class ReplyViewController: UIViewController {
    private let contentView = ReplyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
        addTargets()
    }
    
    func setupView() {
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
//        contentView.postButton.addTarget(self, action: #selector(postPressed), for: .touchUpInside)
        contentView.stickButton.addTarget(self, action: #selector(stickPressed), for: .touchUpInside)
    }
    
    func setupNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "CloseIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func stickPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ReplyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
                        
            contentView.lineHeight += newHeight

            self.updateViewConstraints()
            self.view.layoutIfNeeded()
            
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.2) else { return }
//            image = imageData
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
