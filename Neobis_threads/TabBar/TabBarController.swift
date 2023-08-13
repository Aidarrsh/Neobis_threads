//
//  TabBarController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.frame.size.height = 83
        tabBar.tintColor = .black
//        tabBar.backgroundColor = .black
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let vc5 = ProfileViewController()
        
        vc5.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ProfileTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        
        
        let vc1 = createVC(vc: UIViewController(), itemName: "", itemImage: "HomeTab")
        vc1.view.backgroundColor = .white
        
        let vc2 = createVC(vc: UIViewController(), itemName: "", itemImage: "SearchTab")
        vc2.view.backgroundColor = .white
        
        let vc3 = createVC(vc: UIViewController(), itemName: "", itemImage: "WriteTab")
        vc3.view.backgroundColor = .white
        
        let vc4 = createVC(vc: UIViewController(), itemName: "", itemImage: "ActivityTab")
        vc4.view.backgroundColor = .white
        
        viewControllers = [vc1, vc2, vc3, vc4, vc5]
    }
    
    func createVC(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(named: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        
        let vc1 = UINavigationController(rootViewController: vc)
        vc1.tabBarItem = item
        
        return vc1
    }
}
