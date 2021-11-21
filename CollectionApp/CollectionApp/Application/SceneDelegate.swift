//
//  SceneDelegate.swift
//  CollectionApp
//
//  Created by Александр Фомин on 19.11.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		let appNavigationController = AppNavigationController()
		window.rootViewController = appNavigationController
		self.window = window
		self.window?.makeKeyAndVisible()
	}
}
