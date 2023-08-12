//
//  EditProfileViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import SnapKit
import UIKit

class EditProfileViewController: UIViewController {
    
    private let contentView = EditProfileView()
    
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
