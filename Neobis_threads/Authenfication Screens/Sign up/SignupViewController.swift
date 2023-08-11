//
//  SignupViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 11/8/23.
//

import SnapKit
import UIKit

class SignupViewController: UIViewController {
    
    private let contentView = SignupView()
    
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
