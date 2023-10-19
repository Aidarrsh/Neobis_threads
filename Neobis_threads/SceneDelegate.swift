//
//  SceneDelegate.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 2/8/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let _ = (scene as? UIWindowScene) else { return }
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
//        window?.rootViewController = UINavigationController(rootViewController: TabBarController())
        window?.rootViewController = UINavigationController(rootViewController: LoginViewController (loginProtocol: LoginViewModel()))
//        window?.rootViewController = UINavigationController(rootViewController: ProfileViewController(profileProtocol: ProfileViewModel()))
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

