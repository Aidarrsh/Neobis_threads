//
//  SearchViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 27/8/23.
//

import UIKit
import SnapKit
import Kingfisher

class SearchViewController: UIViewController {
    private let contentView = SearchView()
    
    var isFollowButtonTapped = false
    var searchDataProtocol: SearchDataProtocol
    var userCount: Int?
    var userName: String?
    var searchedUser: SearchedUser?
    var users = Users(users: [])
    var useId: Int?
    
    init( searchDataProtocol: SearchDataProtocol) {
        self.searchDataProtocol = searchDataProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addTargets()
    }
    
    
    func addTargets() {
        
    }
    
    func setupView() {
        contentView.searchBar.delegate = self
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func parseData(_ userData: [UsersList]) {
        userCount = userData.count
        searchDataProtocol.usersList = userData
        
//        for i in searchDataProtocol.usersList {
//            searchDataProtocol.fetchSearchData(username: i.username)
//        }
        contentView.tableView.reloadData()
        DispatchQueue.main.async {
            self.contentView.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            searchDataProtocol.fetchSearchData2(username: searchText)
        }
        
        searchDataProtocol.usersResult = { [weak self] users in
            DispatchQueue.main.async {
                self?.parseData(users)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDataProtocol.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomSearchCell
        
        let user = searchDataProtocol.usersList[indexPath.row]
//        print(user.full_name)
        
        cell.usernameLabel.text = user.username
        cell.jobLabel.text = user.full_name
        
        cell.avatarImage.image = UIImage(named: "UserPicture")
        
        if let photoURLString = user.photo, let photoURL = URL(string: photoURLString) {
            cell.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
            }
        }
        
        cell.followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        let newTitle = isFollowButtonTapped ? "Following" : "Follow"
        cell.followButton.setTitle(newTitle, for: .normal)
        
        return cell
    }
    
    
    
    @objc func followButtonTapped() {
        isFollowButtonTapped = !isFollowButtonTapped
        
        print("asdasd")
        contentView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SomeoneProfileViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // Return false for the cells you want to disable selection for.
        return true
    }
}
