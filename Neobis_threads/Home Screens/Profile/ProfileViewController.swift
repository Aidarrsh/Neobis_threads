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
    var photoString: String?
    var feeds = [Post]()
    
    init(profileProtocol: ProfileProtocol) {
        self.profileProtocol = profileProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getProfileData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        parseFeedsData()
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
        self.photoString = userData["photo"] as? String
        
        DispatchQueue.main.async {
            self.contentView.tableView.reloadData()
        }
    }
    
    func parseFeedsData() {
        self.profileProtocol.fetchFeedsData { [weak self] feeds in
            self?.feeds = feeds
            
            DispatchQueue.main.async {
                self?.contentView.tableView.reloadData()
            }
        }
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
    let model = ["Innovation sets leaders apart from followers.", "When I look at you, I see someone who’s working hard"]
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomProfileCell
        let feed = feeds[indexPath.row]
        
        cell.avatarImage.image = UIImage(named: "UserPicture")
        cell.usernameLabel.text = username
        
        if let photoURLString = photoString, let photoURL = URL(string: photoURLString) {
            cell.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
            }
        }
        
        if feed.image != nil {
            if let photoURLString = feed.image, let photoURL = URL(string: photoURLString) {
                cell.postImage.kf.setImage(with: photoURL) { result in
                    switch result {
                    case .success(let imageResult):
                        let aspectRatio = imageResult.image.size.width / imageResult.image.size.height
                        let newHeight = cell.postImage.frame.width / aspectRatio
                        
                        cell.postImage.snp.updateConstraints { make in
                            make.height.equalTo(newHeight)
                        }
                        
                        cell.postImage.layer.cornerRadius = 10
                        
                        self.updateViewConstraints()
                        
                        cell.layoutIfNeeded()
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    }
                }
            } else {
                cell.postImage.image = nil
            }
        } else {
            cell.postImage.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            
            self.updateViewConstraints()
        }

        let timeAgo = timeAgoSinceDate(dateString: feed.date_posted)
        cell.timeLabel.text = timeAgo
        cell.threadLabel.text = feed.text

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
