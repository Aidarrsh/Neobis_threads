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
    
    var editProfileDataProtocol: SetProfileDataProtocol
    var editProfilePhotoProtocol: SetProfilePhotoProtocol
    var isEditButtonPressed = false
    var username: String?
    var name: String?
    var bio: String?
    var link: String?
    var photo: UIImage?
    
    init(editProfileProtocol: SetProfileDataProtocol, editPhotoProtocol: SetProfilePhotoProtocol, username: String?, name: String?, bio: String?, link: String?, photo: UIImage?) {
        self.editProfileDataProtocol = editProfileProtocol
        self.editProfilePhotoProtocol = editPhotoProtocol
        self.username = username
        self.name = name
        self.bio = bio
        self.link = link
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseUserData()
        addTargets()
        setupView()
        setupTapGesture()
    }
    
    func parseUserData() {
        contentView.usernameTextField.text = username
        contentView.nameTextField.text = name
        contentView.bioTextField.text = bio
        contentView.linkTextField.text = link
        contentView.profilePicture.image = photo
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
        contentView.closeButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        contentView.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    
    @objc func backPressed() {
        dismiss(animated: true)
    }
    
    @objc func doneButtonPressed() {
        
        guard let username = contentView.usernameTextField.text else { return }
        guard let full_name = contentView.nameTextField.text else { return }
        guard let bio = contentView.bioTextField.text else { return }
        guard let website = contentView.bioTextField.text else { return }
        
        editProfileDataProtocol.setData(username: username, full_name: full_name, bio: bio, website: website)
        
        editProfileDataProtocol.setDataResult = { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
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
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else { return }
            editProfilePhotoProtocol.setPhoto(photoData: imageData)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
