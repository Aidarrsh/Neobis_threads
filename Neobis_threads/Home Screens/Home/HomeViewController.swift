//
//  MainPageViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 15/8/23.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var feedsProtocol: HomeProtocol
    var forYouFeeds = [Post]()
    var followingFeeds = [Post]()
    var isRepostButtonPressed = false
    private var forYouRefreshControl = UIRefreshControl()
    private var followingRefreshControl = UIRefreshControl()
    
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(.white)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let contentView = HomeView()
    
    //quick look
    
    init(feedsProtocol: HomeProtocol) {
        self.feedsProtocol = feedsProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parseData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.forYouTableView.register(CustomHomeForYouCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        contentView.forYouTableView.delegate = self
        contentView.forYouTableView.dataSource = self
        
        contentView.followingTableView.register(CustomHomeFollowingCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        contentView.followingTableView.delegate = self
        contentView.followingTableView.dataSource = self

        forYouRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        contentView.forYouTableView.addSubview(forYouRefreshControl)
        
        followingRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        contentView.followingTableView.addSubview(followingRefreshControl)
        
        parseData()
        setupView()
        setupTapGesture()
        addTargets()
    }

    private func showLoadingView() {
        loadingView.isHidden = false
        contentView.isHidden = true
        activityIndicator.startAnimating()
    }

    private func hideLoadingView() {
        loadingView.isHidden = true
        contentView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        showLoadingView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hideLoadingView()
        }
    }
    
    func parseData() {
        self.feedsProtocol.fetchForYouFeedsData { [weak self] feeds in
            self?.forYouFeeds = feeds
            
            DispatchQueue.main.async {
                self?.contentView.forYouTableView.reloadData()
                self?.forYouRefreshControl.endRefreshing()
            }
        }
        
        self.feedsProtocol.fetchFollowingFeedsData { [weak self] feeds in
            self?.followingFeeds = feeds
            
            DispatchQueue.main.async {
                self?.contentView.followingTableView.reloadData()
                self?.followingRefreshControl.endRefreshing()
            }
        }
    }
    
    func addTargets() {
        contentView.forYouSectionButton.addTarget(self, action: #selector(forYouSectionButtonPressed), for: .touchUpInside)
        contentView.followingSectionButton.addTarget(self, action: #selector(followingSectionButtonPressed), for: .touchUpInside)
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside(_:)))
        tapGesture.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapGesture)
    }
    
    func presentBottomSheet() {
        contentView.presentBottomSheet()
    }

    func dismissBottomSheet() {
        contentView.dismissBottomSheet()
    }
    
    @objc func forYouSectionButtonPressed() {
        contentView.followingTableView.isHidden = true
        contentView.forYouTableView.isHidden = false
        contentView.leftSectionBottomLine.backgroundColor = .black
        contentView.rightSectionBottomLine.backgroundColor = .gray
        parseData()
        DispatchQueue.main.async {
            self.contentView.followingTableView.reloadData()
            self.contentView.forYouTableView.reloadData()
        }
    }
    
    @objc func followingSectionButtonPressed() {
        contentView.followingTableView.isHidden = false
        contentView.forYouTableView.isHidden = true
        contentView.leftSectionBottomLine.backgroundColor = .gray
        contentView.rightSectionBottomLine.backgroundColor = .black
        parseData()
        DispatchQueue.main.async {
            self.contentView.followingTableView.reloadData()
            self.contentView.forYouTableView.reloadData()
        }
    }
    
    @objc private func handleTapOutside(_ sender: UITapGestureRecognizer) {
        if isRepostButtonPressed == true {
            let location = sender.location(in: contentView)
            
            if !contentView.bottomSheet.frame.contains(location) {
                if sender.state == .ended {
                    dismissBottomSheet()
                    isRepostButtonPressed = false
                }
            }
        }
    }
    
    @objc private func refreshData() {
        parseData()

        contentView.forYouTableView.reloadData()
        contentView.followingTableView.reloadData()

        forYouRefreshControl.endRefreshing()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == contentView.forYouTableView {
            return forYouFeeds.count
        } else {
            return followingFeeds.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == contentView.forYouTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomHomeForYouCell
            let feed = forYouFeeds[indexPath.row]
            
            cell.avatarImage.image = UIImage(named: "UserPicture")
            cell.usernameLabel.text = "Loading..."
            cell.likesLabel.text = "0 likes"
            cell.likeButton.setImage(UIImage(named: "LikeIcon"), for: .normal)
            
            feedsProtocol.fetchSearchData(id: feed.author) { userData in
                if let userData = userData {
                    DispatchQueue.main.async {
                        cell.usernameLabel.text = userData.username
                        
                        if let photoURLString = userData.photo, let photoURL = URL(string: photoURLString) {
                            cell.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
                            }
                        }
                    }
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
            
            cell.likeButton.addTarget(self, action: #selector(likeButtonPressed(sender:)), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row
            if feed.user_like == true {
                cell.likeButton.setImage(UIImage(named: "LikePressed"), for: .normal)
            }
            
            cell.repostButton.addTarget(self, action: #selector(repostButtonPressed(sender:)), for: .touchUpInside)
            cell.repostButton.tag = indexPath.row
            cell.likesLabel.text = "\(feed.total_likes) likes"
            
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomHomeFollowingCell
            let feed = followingFeeds[indexPath.row]
            
            cell.avatarImage.image = UIImage(named: "UserPicture")
            cell.usernameLabel.text = "Loading..."
            cell.likesLabel.text = "0 likes"
            cell.likeButton.setImage(UIImage(named: "LikeIcon"), for: .normal)
            
            feedsProtocol.fetchSearchData(id: feed.author) { userData in
                if let userData = userData {
                    DispatchQueue.main.async {
                        cell.usernameLabel.text = userData.username
                        
                        if let photoURLString = userData.photo, let photoURL = URL(string: photoURLString) {
                            cell.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
                            }
                        }
                    }
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
            
            cell.likeButton.addTarget(self, action: #selector(likeButtonPressed(sender:)), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row
            if feed.user_like == true {
                cell.likeButton.setImage(UIImage(named: "LikePressed"), for: .normal)
            }
            
            cell.repostButton.addTarget(self, action: #selector(repostButtonPressed(sender:)), for: .touchUpInside)
            cell.repostButton.tag = indexPath.row
            
            DispatchQueue.main.async {
                cell.likesLabel.text = "\(feed.total_likes) likes"
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    @objc func likeButtonPressed(sender: UIButton) {
        let indexPathRow = sender.tag
        let newImage = sender.imageView?.image == UIImage(named: "LikeIcon") ? UIImage(named: "LikePressed") : UIImage(named: "LikeIcon")
        sender.setImage(newImage, for: .normal)
        
        feedsProtocol.fetchlikeData(id: forYouFeeds[indexPathRow].id)
    }
    
    @objc func repostButtonPressed(sender: UIButton) {
        let indexPathRow = sender.tag
        print(forYouFeeds[indexPathRow].id)
        if isRepostButtonPressed == false{
            presentBottomSheet()
            isRepostButtonPressed = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == contentView.forYouTableView {
            let vc = ThreadViewController(threadProtocol: ThreadViewModel(), postId: forYouFeeds[indexPath.row].id)
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        } else {
            let vc = ThreadViewController(threadProtocol: ThreadViewModel(), postId: followingFeeds[indexPath.row].id)
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
