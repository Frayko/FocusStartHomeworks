//
//  AppTabBarController.swift
//  myCV
//
//  Created by Александр Фомин on 15.11.2021.
//

import UIKit

final class AppTabBarController: UITabBarController {
	private let dataMapper = DataMapper()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureTabBar()
		configureTabs()
	}
}

private extension AppTabBarController {
	func configureTabBar() {
		self.tabBar.backgroundColor = UIColor.systemBackground
		self.tabBar.tintColor = UIColor.label
		
		let topBorder = CALayer()
		topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.tabBar.frame.width, height: 1.0)
		topBorder.backgroundColor = UIColor.gray.cgColor
		self.tabBar.layer.addSublayer(topBorder)
	
		self.selectedIndex = 0
	}
	
	func configureTabs() {
		let profileTabVC = ScreensFactory.makeProfileScreen()
		profileTabVC.tabBarItem = createAboutMeTab()
		
		let skillsTabVC = ScreensFactory.makeSkillsScreen()
		skillsTabVC.tabBarItem = createSkillsTab()
		
		let interestsTabVC = ScreensFactory.makeInterestsScreen()
		interestsTabVC.tabBarItem = createInterestsTab()
		
		self.setViewControllers([profileTabVC, skillsTabVC, interestsTabVC], animated: false)
	}
	
	func createAboutMeTab() -> UITabBarItem {
		let item = UITabBarItem(title: "Обо мне",
								image: UIImage(systemName: "person.text.rectangle"),
								selectedImage: UIImage(systemName: "person.text.rectangle.fill"))
		return item
	}
	
	func createSkillsTab() -> UITabBarItem {
		let item = UITabBarItem(title: "Навыки",
								image: UIImage(systemName: "books.vertical"),
								selectedImage: UIImage(systemName: "books.vertical.fill"))
		return item
	}
	
	func createInterestsTab() -> UITabBarItem {
		let item = UITabBarItem(title: "Интересы",
								image: UIImage(systemName: "paintpalette"),
								selectedImage: UIImage(systemName: "paintpalette.fill"))
		return item
	}
}
