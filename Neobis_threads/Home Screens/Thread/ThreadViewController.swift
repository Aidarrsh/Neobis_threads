//
//  ThreadViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 19/8/23.
//

import UIKit
import SnapKit

class ThreadViewController: UIViewController {
    private let contentView = ThreadView()
    
    var threadProtocol: ThreadProtocol
    var postId: Int
    
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
    }
    
    func parseData() {
        threadProtocol.fetchPostData(id: postId) { postData in
            DispatchQueue.main.async {
                self.contentView.threadLabel.text = postData?.text
                
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
                    
                    if let photoURLString = userData?.photo, let photoURL = URL(string: photoURLString) {
                        self.contentView.avatarImage.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
                        }
                    }
                    
                }
            }
        }
    }
    
    func setupView() {
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ThreadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomThreadCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
