//
//  ThreadViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 19/8/23.
//

import UIKit
import SnapKit
import Kingfisher

class ThreadViewController: UIViewController {
    private let contentView = ThreadView()
    
    var threadProtocol: ThreadProtocol
    var postId: Int
    var commentsList = [Comment]()
    
    init(threadProtocol: ThreadProtocol, postId: Int) {
        self.threadProtocol = threadProtocol
        self.postId = postId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseData()
        setupView()
        setupNavigation()
        addTargets()
    }
    
    func parseData() {
        threadProtocol.fetchPostData(id: postId) { postData in
            DispatchQueue.main.async {
                self.contentView.threadLabel.text = postData?.text
                
                let likes = postData?.total_likes ?? 0
                self.contentView.likesLabel.text = "\(likes) likes"
                
                let reply = postData?.total_comments ?? 0
                self.contentView.replyLabel.text = "\(reply) reply"
                
                if postData?.user_like ==  true {
                    self.contentView.likeButton.setImage(UIImage(named: "LikePressed"), for: .normal)
                }

                if postData?.image != nil {
                    if let photoURLString = postData?.image, let photoURL = URL(string: photoURLString) {
                        self.contentView.postImage.kf.setImage(with: photoURL) { result in
                            switch result {
                            case .success(let imageResult):
                                let aspectRatio = imageResult.image.size.width / imageResult.image.size.height
                                let newHeight = self.contentView.postImage.frame.width / aspectRatio
                                
                                self.contentView.postImage.snp.makeConstraints { make in
                                    make.height.equalTo(newHeight)
                                }
                                
                                self.contentView.postImage.layer.cornerRadius = 10
                                
                                self.updateViewConstraints()
                                
                                self.contentView.layoutIfNeeded()
                            case .failure(let error):
                                print("Error loading image: \(error)")
                            }
                        }
                    } else {
                        self.contentView.postImage.image = nil
                    }
                } else {
                    self.contentView.postImage.snp.makeConstraints { make in
                        make.height.equalTo(0)
                    }
                    
                    self.updateViewConstraints()
                }
                
                let timeAgo = self.timeAgoSinceDate(dateString: postData?.date_posted ?? "")
                self.contentView.timeLabel.text = timeAgo
            }
            self.threadProtocol.fetchSearchData(id: postData?.author ?? 0) { userData in
                DispatchQueue.main.async {
                    self.contentView.usernameLabel.text = userData?.username
                    self.contentView.replyButton.setTitle("Reply to " + (userData?.username ?? ""), for: .normal)
                    
                    if let photoURLString = userData?.photo, let photoURL = URL(string: photoURLString) {
                        self.contentView.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
                        }
                    }
                    
                }
            }
        }
        
        threadProtocol.fetchUserData() { [weak self] result in
            switch result {
            case .success(let userData):
                if let photoURLString = userData["photo"] as? String,
                   let photoURL = URL(string: photoURLString) {
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: photoURL),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                self?.contentView.replyAvatarImage.image = image
                            }
                        } else {
                            print("Failed to load image from URL:", photoURL)
                        }
                    }
                }
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
        
        threadProtocol.fetchCommentsData(id: postId) { [weak self] comments in
            self?.setComments(with: comments)
            DispatchQueue.main.async {
                self?.contentView.tableView.reloadData()
            }
        }

    }
    
    func setupView() {
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(CustomThreadCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    func addTargets() {
        contentView.likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        contentView.replyButton.addTarget(self, action: #selector(replyButtonPressed), for: .touchUpInside)
    }
    
    func setComments(with comments: [Comment]) {
        commentsList = comments
    }
    
    @objc func likeButtonPressed() {
        let newImage = contentView.likeButton.imageView?.image == UIImage(named: "LikeIcon") ? UIImage(named: "LikePressed") : UIImage(named: "LikeIcon")
        contentView.likeButton.setImage(newImage, for: .normal)
        
        threadProtocol.fetchlikeData(id: postId)
    }
    
    @objc func replyButtonPressed() {
        let vc = ReplyViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ThreadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomThreadCell
        let comment = commentsList[indexPath.row]
        cell.commentLabel.text = comment.text
        cell.avatarImage.image = UIImage(named: "UserPicture")
        threadProtocol.fetchSearchData(id: comment.author) { [weak self] userData in
            DispatchQueue.main.async {
                cell.usernameLabel.text = userData?.username
                if let photoURLString = userData?.photo, let photoURL = URL(string: photoURLString) {
                    cell.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
