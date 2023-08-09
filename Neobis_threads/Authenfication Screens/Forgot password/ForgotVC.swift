//
//  ForgotVC.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 8/8/23.
//

import SnapKit
import UIKit

class ForgotVC: UIViewController {
    
    private let contentView = ForgotView()
    
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
