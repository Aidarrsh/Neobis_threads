//
//  FollowersViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 29/9/23.
//

import UIKit
import SnapKit
import Kingfisher

class FollowersViewController: UIViewController {
    private let contentView = FollowersView()
    var followersProtocol: FollowersProtocol
    var followersList = [Followee]()
    var followeeList = [Followee]()
    var userId: Int
    
    init(followersProtocol: FollowersProtocol, userId: Int) {
        self.followersProtocol = followersProtocol
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentView.underlineOne.isHidden = false
        contentView.underlineTwo.isHidden = true
        contentView.underlineThree.isHidden = true
        contentView.followersTableView.isHidden = false
        contentView.followingTableView.isHidden = true
        contentView.pendingTableView.isHidden = true
        parseData()
        DispatchQueue.main.async {
            self.contentView.followersTableView.reloadData()
            self.contentView.followingTableView.reloadData()
            self.contentView.pendingTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.searchBar.delegate = self
        contentView.followersTableView.delegate = self
        contentView.followersTableView.dataSource = self
        contentView.followingTableView.delegate = self
        contentView.followingTableView.dataSource = self
        contentView.pendingTableView.delegate = self
        contentView.pendingTableView.dataSource = self
        setupView()
        addTargets()
        parseData()
    }
    
    func setupView() {
        view.addSubview(contentView)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.followersButton.addTarget(self, action: #selector(followersPressed), for: .touchUpInside)
        contentView.followingButton.addTarget(self, action: #selector(followingPressed), for: .touchUpInside)
        contentView.pendingButton.addTarget(self, action: #selector(pendingPressed), for: .touchUpInside)
    }
    
    func parseData() {
        followersProtocol.followsFetchData(id: userId) { [weak self] result in
            self?.setFollowees(with: result)
            DispatchQueue.main.async {
                self?.contentView.followersTableView.reloadData()
            }
        }
        
        followersProtocol.followersFetchData(id: userId) { [weak self] result in
            self?.setFollowers(with: result)
            DispatchQueue.main.async {
                self?.contentView.followingTableView.reloadData()
            }
        }
        
        DispatchQueue.main.async {
            self.contentView.followersTableView.reloadData()
            self.contentView.followingTableView.reloadData()
        }
    }
    
    func setFollowees(with followees: [Followee]) {
        followeeList = followees
    }
    
    func setFollowers(with followers: [Followee]) {
        followersList = followers
    }
    
    @objc func followersPressed() {
        contentView.underlineOne.isHidden = false
        contentView.underlineTwo.isHidden = true
        contentView.underlineThree.isHidden = true
        contentView.followersTableView.isHidden = false
        contentView.followingTableView.isHidden = true
        contentView.pendingTableView.isHidden = true
        DispatchQueue.main.async {
            self.contentView.followersTableView.reloadData()
            self.contentView.followingTableView.reloadData()
            self.contentView.pendingTableView.reloadData()
        }
    }
    
    @objc func followingPressed() {
        contentView.underlineOne.isHidden = true
        contentView.underlineTwo.isHidden = false
        contentView.underlineThree.isHidden = true
        contentView.followersTableView.isHidden = true
        contentView.followingTableView.isHidden = false
        contentView.pendingTableView.isHidden = true
        DispatchQueue.main.async {
            self.contentView.followersTableView.reloadData()
            self.contentView.followingTableView.reloadData()
            self.contentView.pendingTableView.reloadData()
        }
    }
    
    @objc func pendingPressed() {
        contentView.underlineOne.isHidden = true
        contentView.underlineTwo.isHidden = true
        contentView.underlineThree.isHidden = false
        contentView.followersTableView.isHidden = true
        contentView.followingTableView.isHidden = true
        contentView.pendingTableView.isHidden = false
        DispatchQueue.main.async {
            self.contentView.followersTableView.reloadData()
            self.contentView.followingTableView.reloadData()
            self.contentView.pendingTableView.reloadData()
        }
    }
}

extension FollowersViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == contentView.followersTableView {
            return followersList.count
        } else if tableView == contentView.followingTableView {
            return followeeList.count
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == contentView.followersTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomFollowersCell
            let follower = followersList[indexPath.row]
            cell.usernameLabel.text = follower.username
            cell.jobLabel.text = follower.full_name
            cell.avatarImage.image = UIImage(named: "UserPicture")
            
            if let photoURL = URL(string: follower.photo ?? "") {
                cell.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in }
            }
            
//            followersProtocol.fetchMutualData(followee: follower.pk)
//            
//            followersProtocol.setMutualResult = { [weak self] result in
//                switch result {
//                case .success(let (_, responseString)):
//                    if responseString.contains("Pending"){
//                        cell.followButton.setTitle("Requested", for: .normal)
//                        cell.followButton.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
//                    } else if responseString.contains("Not followed") {
//    //                    print("notFollowed")
//                    } else if responseString.contains("Followed") {
//                        cell.followButton.setTitle("Following", for: .normal)
//                        cell.followButton.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
//                    } else if responseString.contains("Mutual Follow") {
//                        cell.followButton.setTitle("Following", for: .normal)
//                        cell.followButton.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
//                    } else {
//                    }
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }
            
            cell.followButton.addTarget(self, action: #selector(followButtonFollowersPressed(sender:)), for: .touchUpInside)
            cell.followButton.tag = indexPath.row
            cell.selectionStyle = .none
            
            return cell
        } else if tableView == contentView.followingTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomFollowingCell
            let followee = followeeList[indexPath.row]
            cell.usernameLabel.text = followee.username
            cell.jobLabel.text = followee.full_name
            cell.avatarImage.image = UIImage(named: "UserPicture")
            
            if let photoURL = URL(string: followee.photo ?? "") {
                cell.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in }
            }
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomPendingCell
            
            return cell
        }
    }
    
    @objc func followButtonFollowersPressed(sender: UIButton) {
        let indexPathRow = sender.tag
        
        followersProtocol.fetchFollowData(id: followersList[indexPathRow].pk)
        
        sender.setTitle("Following", for: .normal)
        sender.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == contentView.followersTableView {
            let selectedUser = followersList[indexPath.row]
            let vc = SomeoneProfileViewController(someoneProfileProtocol: SomeoneProfileViewModel(), userId: selectedUser.pk)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        } else {
            let selectedUser = followeeList[indexPath.row]
            let vc = SomeoneProfileViewController(someoneProfileProtocol: SomeoneProfileViewModel(), userId: selectedUser.pk)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
