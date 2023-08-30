//
//  ReplyViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 21/8/23.
//

import UIKit
import SnapKit

class ReplyViewController: UIViewController {
    private let contentView = ReplyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
