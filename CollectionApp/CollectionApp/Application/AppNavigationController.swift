//
//  AppNavigationController.swift
//  CollectionApp
//
//  Created by Александр Фомин on 22.11.2021.
//

import UIKit

final class AppNavigationController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigationController()
		configureView()
	}
}

private extension AppNavigationController {
	func configureNavigationController() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .systemBackground
		navigationBar.standardAppearance = appearance
		navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
		
		self.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward.circle.fill")
		self.navigationBar.tintColor = .systemTeal
		self.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward.circle.fill")
	}
	
	func configureView() {
		let animeCollectionVC = AnimeCollectionVC()
		
		self.setViewControllers([animeCollectionVC], animated: true)
	}
}
