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
