//
//  SceneDelegate.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		let viewController = LoadImagesAssembly.build()
		window.rootViewController = viewController
		self.window = window
		self.window?.makeKeyAndVisible()
	}
}

