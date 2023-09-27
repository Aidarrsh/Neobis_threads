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
    private let contentView = HomeView()
    
    var feedsProtocol: HomeProtocol
    var feeds = [Post]()
    
    init(feedsProtocol: HomeProtocol) {
        self.feedsProtocol = feedsProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        DispatchQueue.main.async {
            self.parseData()
        }
        setupView()
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
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

        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ThreadViewController()
        print(feeds[indexPath.row].id)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }

}
