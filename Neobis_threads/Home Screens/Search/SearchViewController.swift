//
//  SearchViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 27/8/23.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    private let contentView = SearchView()
    
    var isFollowButtonTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addTargets()
    }
    
    func addTargets() {
        
    }
    
    func setupView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomSearchCell
        
        cell.followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        
        // Update the button title based on the isFollowButtonTapped flag
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
