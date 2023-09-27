//
//  ProfileViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    
    private let contentView = ProfileView()
    
    var profileProtocol: ProfileProtocol
    var username: String?
    var name: String?
    var bio: String?
    var link: String?
    var photo: UIImage?
    
    init(profileProtocol: ProfileProtocol) {
        self.profileProtocol = profileProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        getProfileData()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getProfileData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getProfileData()
        addTargets()
    }
    
    func getProfileData() {
        DispatchQueue.main.async {
            self.profileProtocol.fetchUserData() { [weak self] result in
                switch result {
                case .success(let userData):
                    self?.parseUserData(userData)
                case .failure(let error):
                    print("Failed to fetch user data:", error)
                }
            }
        }
    }
    
    func parseUserData(_ userData: [String: Any]) {
        if let username = userData["username"] as? String {
            DispatchQueue.main.async {
                self.contentView.nicknameLabel.text = username
            }
        }
        
        if let photoURLString = userData["photo"] as? String,
           let photoURL = URL(string: photoURLString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: photoURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.contentView.profilePicture.image = image
                        self.photo = image
                    }
                } else {
                    print("Failed to load image from URL:", photoURL)
                }
            }
            
        }
        
        if let full_name = userData["full_name"] as? String {
            DispatchQueue.main.async {
                self.contentView.professionLabel.text = full_name
            }
        }
        
        self.username = userData["username"] as? String
        self.name = userData["full_name"] as? String
        self.bio = userData["bio"] as? String
        self.link = userData["website"] as? String
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        contentView.nicknameLabel.text = "Loading..."
    }
    
    func addTargets() {
        contentView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        contentView.exitButton.addTarget(self, action: #selector(exitPressed), for: .touchUpInside)
    }
    
    @objc func exitPressed() {
        dismiss(animated: true)
    }
    
    @objc func editButtonTapped() {
        let vc = EditProfileViewController(editProfileProtocol: EditProfileSetDataViewModel(),
                                           editPhotoProtocol: EditProfileSetPhotoViewModel(),
                                           username: username,
                                           name: name, bio: bio,
                                           link: link,
                                           photo: photo)
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
