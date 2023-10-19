//
//  SomeoneProfileViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 1/9/23.
//

import SnapKit
import UIKit

class SomeoneProfileViewController: UIViewController {
    
    private let contentView = SomeoneProfileView()
    
    var someoneProfileProtocol: SomeoneProfileProtocol
    var username: String?
    var photoString: String?
    var userId: Int
    var isShareButtonPressed = false
    var feeds = [Post]()
    
    init(someoneProfileProtocol: SomeoneProfileProtocol, userId: Int) {
        self.someoneProfileProtocol = someoneProfileProtocol
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addTargets()
        setupTapGesture()
        parseData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        parseData()
    }
    
    func parseData() {
        someoneProfileProtocol.fetchSearchData(id: userId) { userData in
            DispatchQueue.main.async {
                self.contentView.professionLabel.text = userData?.username
                self.username = userData?.username
                self.contentView.nicknameLabel.text = userData?.full_name
                
                if let photoURLString = userData?.photo, let photoURL = URL(string: photoURLString) {
                    self.contentView.profilePicture.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
                    }
                    self.photoString = userData?.photo as? String
                }
            }
        }
        
        someoneProfileProtocol.fetchMutualData(followee: userId)
        
        someoneProfileProtocol.setMutualResult = { [weak self] result in
            switch result {
            case .success(let (_, responseString)):
                if responseString.contains("Pending"){
                    self?.contentView.followButton.setTitle("Pending", for: .normal)
                    self?.contentView.followButton.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
                    self?.contentView.followButton.backgroundColor = .clear
                    self?.contentView.followButton.layer.borderColor = UIColor(named: "GreyLabel")?.cgColor
                    self?.contentView.followButton.layer.borderWidth = 1
                } else if responseString.contains("Not followed") {
//                    print("notFollowed")
                } else if responseString.contains("Followed") {
                    self?.contentView.followButton.setTitle("Following", for: .normal)
                    self?.contentView.followButton.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
                    self?.contentView.followButton.backgroundColor = .clear
                    self?.contentView.followButton.layer.borderColor = UIColor(named: "GreyLabel")?.cgColor
                    self?.contentView.followButton.layer.borderWidth = 1
                } else if responseString.contains("Mutual Follow") {
                    self?.contentView.followButton.setTitle("Following", for: .normal)
                    self?.contentView.followButton.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
                    self?.contentView.followButton.backgroundColor = .clear
                    self?.contentView.followButton.layer.borderColor = UIColor(named: "GreyLabel")?.cgColor
                    self?.contentView.followButton.layer.borderWidth = 1
                } else {
                    print(responseString)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        someoneProfileProtocol.fetchFeedsData(id: userId) { [weak self] feeds in
            self?.feeds = feeds
            
            DispatchQueue.main.async {
                self?.contentView.tableView.reloadData()
            }
        }
    }
    
    func setupView() {
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let shareButton = UIBarButtonItem(image: UIImage(named: "ShareIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(shareButtonPressed))
        self.navigationItem.rightBarButtonItem = shareButton
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(CustomSomeoneProfileCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
    }
    
    func addTargets() {
        contentView.followButton.addTarget(self, action: #selector(followButtonPressed), for: .touchUpInside)
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside(_:)))
        tapGesture.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func followButtonPressed() {
        someoneProfileProtocol.fetchFollowData(id: userId)
        contentView.followButton.setTitle("Following", for: .normal)
        contentView.followButton.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
        contentView.followButton.backgroundColor = .clear
        contentView.followButton.layer.borderColor = UIColor(named: "GreyLabel")?.cgColor
        contentView.followButton.layer.borderWidth = 1
    }
    
    @objc private func handleTapOutside(_ sender: UITapGestureRecognizer) {
        if isShareButtonPressed == true {
            let location = sender.location(in: contentView.bottomSheet)
            
            if !contentView.bottomSheet.bounds.contains(location) {
                if sender.state == .ended {
                    contentView.dismissBottomSheet()
                    isShareButtonPressed = false
                }
            }
        }
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    @objc func shareButtonPressed() {
        if isShareButtonPressed == false{
            contentView.presentBottomSheet()
            isShareButtonPressed = true
        }
    }
}

extension SomeoneProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomSomeoneProfileCell
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
                        
                        cell.heightConstraint?.constant = newHeight
                        
                        cell.postImage.layer.cornerRadius = 10
                        
                        self.contentView.updateConstraints()
                        
                        cell.layoutIfNeeded()
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    }
                }
            } else {
                cell.postImage.image = nil
            }
        }

        let timeAgo = timeAgoSinceDate(dateString: feed.date_posted)
        cell.timeLabel.text = timeAgo
        cell.threadLabel.text = feed.text
        cell.likesLabel.text = "\(feed.total_likes) likes"
        cell.likeButton.setImage(UIImage(named: "LikeIcon"), for: .normal)
        cell.likeButton.addTarget(self, action: #selector(likeButtonPressed(sender:)), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        if feed.user_like == true {
            cell.likeButton.setImage(UIImage(named: "LikePressed"), for: .normal)
        }

        cell.selectionStyle = .none
        return cell
    }
    
    @objc func likeButtonPressed(sender: UIButton) {
        let indexPathRow = sender.tag
        let newImage = sender.imageView?.image == UIImage(named: "LikeIcon") ? UIImage(named: "LikePressed") : UIImage(named: "LikeIcon")
        sender.setImage(newImage, for: .normal)
        
        someoneProfileProtocol.fetchlikeData(id: feeds[indexPathRow].id)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ThreadViewController(threadProtocol: ThreadViewModel(), postId: feeds[indexPath.row].id)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

