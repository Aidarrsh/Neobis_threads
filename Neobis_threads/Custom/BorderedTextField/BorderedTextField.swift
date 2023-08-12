//
//  BorderedTextField.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import Foundation
import UIKit
import SnapKit

class BorderedTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.sublayers?.forEach { if $0.name == "bottomLine" { $0.removeFromSuperlayer() } }
        
        font = UIFont.sfRegular(ofSize: 15)
        
        let bottomLine = CALayer()
        bottomLine.name = "bottomLine"
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        bottomLine.backgroundColor = UIColor(named: "GreyButtonBorder")?.cgColor
        layer.addSublayer(bottomLine)
    }
    
}
