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
    var feeds = [Post]()
    var isRepostButtonPressed = false
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.register(CustomHomeCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self

        setupView()
        setupTapGesture()
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
        
        DispatchQueue.main.async {
            self.parseData()
            self.contentView.tableView.reloadData()
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
        self.feedsProtocol.fetchFeedsData { [weak self] feeds in
            self?.feeds = feeds
            
            DispatchQueue.main.async {
                self?.contentView.tableView.reloadData()
            }
        }
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
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomHomeCell
        let feed = feeds[indexPath.row]
        
        cell.avatarImage.image = UIImage(named: "UserPicture")
        
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
            cell.likeButton.backgroundColor = .red
        }
        
        cell.repostButton.addTarget(self, action: #selector(repostButtonPressed(sender:)), for: .touchUpInside)
        cell.repostButton.tag = indexPath.row

        cell.selectionStyle = .none
        return cell
    }
    
    @objc func likeButtonPressed(sender: UIButton) {
        let indexPathRow = sender.tag
        let newBackgroundColor = sender.backgroundColor == .white ? UIColor.red : UIColor.white
        sender.backgroundColor = newBackgroundColor
        
        feedsProtocol.fetchlikeData(id: feeds[indexPathRow].id)
    }
    
    @objc func repostButtonPressed(sender: UIButton) {
        let indexPathRow = sender.tag
        print(feeds[indexPathRow].id)
        if isRepostButtonPressed == false{
            presentBottomSheet() // Show the bottom sheet
            isRepostButtonPressed = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ThreadViewController(threadProtocol: ThreadViewModel(), postId: feeds[indexPath.row].id)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // Return false for the cells you want to disable selection for.
        return true
    }
}
