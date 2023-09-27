//
//  TabBarController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    let customButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.frame.size.height = 83
        tabBar.tintColor = .black
//        tabBar.backgroundColor = .black
        setupTabBar()
        setupCustomButton()
    }
    
    func setupTabBar() {
        
        let vc1 = HomeViewController(feedsProtocol: HomeViewModel())
        
        vc1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "HomeTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        let vc2 = SearchViewController(searchDataProtocol: SearchGetDataViewModel())
        
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SearchTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        let vc3 = WriteViewController(writeProtocol: WriteViewModel(), profileProtocol: ProfileViewModel())
//
        vc3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "WriteTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        let vc4 = ActivityViewController()
        
        vc4.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ActivityTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        let vc5 = ProfileViewController(profileProtocol: ProfileViewModel())
        
        vc5.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ProfileTab")?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        viewControllers = [vc1, vc2, vc3, vc4, vc5]
    }
    
    func setupCustomButton() {
        customButton.frame.size = CGSize(width: 60, height: 60)
        customButton.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 42) // Adjust position as needed
        customButton.setImage(UIImage(named: "YourButtonImage"), for: .normal)
        customButton.addTarget(self, action: #selector(customButtonPressed), for: .touchUpInside)
        
        view.addSubview(customButton)
    }
    
    @objc func customButtonPressed() {
        let vc = WriteViewController(writeProtocol: WriteViewModel(), profileProtocol: ProfileViewModel())
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }

    
    func createVC(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(named: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        
        let vc1 = UINavigationController(rootViewController: vc)
        vc1.tabBarItem = item
        
        return vc1
    }
}
