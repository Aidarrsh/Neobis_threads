//
//  OTPVC.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 9/8/23.
//

import SnapKit
import UIKit

class OTPVC: UIViewController {
    
    private let contentView = OTPView()
    
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
