//
//  MainPageView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 15/8/23.
//

import Foundation
import UIKit
import SnapKit

class MainPageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(named: "ScreenBackground")
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
}
