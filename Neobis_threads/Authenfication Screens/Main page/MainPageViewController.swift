//
//  MainPageViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 15/8/23.
//

import Foundation
import UIKit
import SnapKit

class MainPageViewController: UIViewController {
    private let contentView = MainPageView()
    
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
