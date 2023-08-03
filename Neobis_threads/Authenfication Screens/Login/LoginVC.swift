//
//  ViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 2/8/23.
//

import UIKit
import SnapKit

class LoginVC: UIViewController {
    
    private let contentView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

