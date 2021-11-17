//
//  SceneDelegate.swift
//  myCV
//
//  Created by Александр Фомин on 10.11.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		let tabBarController = AppTabBarController()
		window.rootViewController = tabBarController
		self.window = window
		self.window?.makeKeyAndVisible()
	}
}
