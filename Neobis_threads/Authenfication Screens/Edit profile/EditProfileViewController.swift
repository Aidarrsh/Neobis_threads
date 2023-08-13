//
//  EditProfileViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import SnapKit
import UIKit

class EditProfileViewController: UIViewController {
    
    private let contentView = EditProfileView()
    
    var isEditButtonPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setupView()
        setupTapGesture()
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.editPhotoButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        contentView.bottomSheet.setProfilePicture.addTarget(self, action: #selector(setProfilePicturePressed), for: .touchUpInside)
    }
    
    @objc func editButtonPressed() {
        if isEditButtonPressed == false{
            contentView.presentBottomSheet()
            isEditButtonPressed = true
        }
    }
    
    @objc func setProfilePicturePressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        contentView.dismissBottomSheet()
        isEditButtonPressed = false
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside(_:)))
        tapGesture.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapOutside(_ sender: UITapGestureRecognizer) {
        if isEditButtonPressed == true {
            let location = sender.location(in: contentView.bottomSheet)
            
            if !contentView.bottomSheet.bounds.contains(location) {
                if sender.state == .ended {
                    contentView.dismissBottomSheet()
                    isEditButtonPressed = false
                }
            }
        }
    }

}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            contentView.profilePicture.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
