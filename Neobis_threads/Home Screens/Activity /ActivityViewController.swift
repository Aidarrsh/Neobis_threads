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
    
    var isFollowButtonTapped = false
    
    var isButtonPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contentView.commentsTableView.isHidden == false {
            return 15
        } else {
            return 15
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == contentView.commentsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomCommentsActivityCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomRequestsActivityCell
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
        // Return false for the cells you want to disable selection for.
        return true
    }
}
