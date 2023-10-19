//
//  ActivityViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 1/9/23.
//

import UIKit
import SnapKit

class ActivityViewController: UIViewController {
    private let contentView = ActivityView()
    var activityProtocol: ActiivtyProtocol
    var follows = [ActivityModel]()
    
    init(activityProtocol: ActiivtyProtocol) {
        self.activityProtocol = activityProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isFollowButtonTapped = false
    
    var isButtonPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseData()
        setupView()
        addTargets()
    }
    
    func addTargets() {
        contentView.commentsButton.addTarget(self, action: #selector(commentsButtonPressed), for: .touchUpInside)
        contentView.requestsButton.addTarget(self, action: #selector(requestsButtonPressed), for: .touchUpInside)
    }
    
    func setupView() {
        contentView.commentsTableView.delegate = self
        contentView.commentsTableView.dataSource = self
        contentView.requestsTableView.delegate = self
        contentView.requestsTableView.dataSource = self
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func parseData() {
        self.activityProtocol.fetchFollowsData() { [weak self] follows in
            // Group notifications by related_user
            let groupedNotifications = Dictionary(grouping: follows, by: { $0.related_user })
            
            // Keep only the latest notification for each related_user
            let latestNotifications = groupedNotifications.compactMap { $0.value.max(by: { $0.datePosted < $1.datePosted }) }
            
            self?.follows = latestNotifications
            
            DispatchQueue.main.async {
                self?.contentView.requestsTableView.reloadData()
            }
        }
    }

    @objc func commentsButtonPressed() {
        if isButtonPressed == true {
            isButtonPressed = false
            contentView.commentsTableView.isHidden = false
            contentView.requestsTableView.isHidden = true
            contentView.commentsButton.setTitleColor(.white, for: .normal)
            contentView.commentsButton.backgroundColor = .black
            contentView.commentsButton.layer.borderWidth = 0
            contentView.requestsButton.setTitleColor(.black, for: .normal)
            contentView.requestsButton.backgroundColor = .white
            contentView.requestsButton.layer.borderWidth = 1
        }
        DispatchQueue.main.async {
            self.contentView.commentsTableView.reloadData()
            self.contentView.requestsTableView.reloadData()
        }
    }
    
    @objc func requestsButtonPressed() {
        if isButtonPressed == false {
            isButtonPressed = true
            contentView.commentsTableView.isHidden = true
            contentView.requestsTableView.isHidden = false
            contentView.requestsButton.setTitleColor(.white, for: .normal)
            contentView.requestsButton.backgroundColor = .black
            contentView.requestsButton.layer.borderWidth = 0
            contentView.commentsButton.setTitleColor(.black, for: .normal)
            contentView.commentsButton.backgroundColor = .white
            contentView.commentsButton.layer.borderWidth = 1
        }
        DispatchQueue.main.async {
            self.contentView.commentsTableView.reloadData()
            self.contentView.requestsTableView.reloadData()
        }
    }
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contentView.commentsTableView.isHidden == false {
            return 15
        } else {
            return follows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == contentView.commentsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomCommentsActivityCell
            
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomRequestsActivityCell
            if indexPath.row < follows.count {
                let followee = follows[indexPath.row]
                
                activityProtocol.fetchUserData(id: followee.related_user ?? 0) { userData in
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
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                let dateString = dateFormatter.string(from: followee.datePosted)
                let timeAgo = timeAgoSinceDate(dateString: dateString)
                cell.timeLabel.text = timeAgo
            } else {
                
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = SomeoneProfileViewController(someoneProfileProtocol: SomeoneProfileViewModel())
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
