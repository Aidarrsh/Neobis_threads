//
//  PasswordVewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 11/8/23.
//

import SnapKit
import UIKit

class PasswordViewController: UIViewController {
    
    private let contentView = PasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal), 
                                         style: .plain, 
                                         target: self, 
                                         action: #selector(backPressed))
        
        self.navigationItem.leftBarButtonItem = backButton
        view.addSubview(contentView) 
        // make in make -> $0.
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
