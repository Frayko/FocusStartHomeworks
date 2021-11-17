//
//  ProfileTabVC.swift
//  myCV
//
//  Created by Александр Фомин on 12.11.2021.
//

import UIKit

protocol IProfileTabVC: UIViewController {
	func setPhoto(named: String)
	func setFullName(_ text: String)
	func setAge(_ age: Int)
	func setDescription(_ text: String)
}

final class ProfileTabVC: UIViewController {
	private let rootView: IProfileTabView = ProfileTabView()
	
	override func loadView() {
		self.view = self.rootView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Обо мне"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.rootView.didLoad()
	}
}

extension ProfileTabVC: IProfileTabVC {
	func setPhoto(named: String) {
		self.rootView.setPhoto(named: named)
	}
	
	func setFullName(_ text: String) {
		self.rootView.setFullName(text)
	}

	func setAge(_ age: Int) {
		self.rootView.setAge(age)
	}
	
	func setDescription(_ text: String) {
		self.rootView.setDescription(text)
	}
}
