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
		self.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward.circle.fill")
		self.navigationBar.tintColor = .systemTeal
		self.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward.circle.fill")
	}
	
	func configureView() {
		let animeCollectionVC = AnimeCollectionVC()
		
		self.setViewControllers([animeCollectionVC], animated: true)
	}
}
