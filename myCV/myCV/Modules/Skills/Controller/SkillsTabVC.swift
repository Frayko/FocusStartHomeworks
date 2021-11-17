//
//  SkillsTabVC.swift
//  myCV
//
//  Created by Александр Фомин on 12.11.2021.
//

import UIKit

protocol ISkillsTabVC: UIViewController {
	func setHistory(_ text: String)
	func addStatistic(languageName: String, languagePhotoName: String, experience: String)
}

final class SkillsTabVC: UIViewController {
	private let rootView: ISkillsTabView = SkillsTabView()
	
	override func loadView() {
		self.view = self.rootView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Навыки"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.rootView.didLoad()
	}
}

extension SkillsTabVC: ISkillsTabVC {
	func setHistory(_ text: String) {
		self.rootView.setHistory(text)
	}
	
	func addStatistic(languageName: String, languagePhotoName: String, experience: String) {
		self.rootView.addStatistic(languageName, languagePhotoName, experience)
	}
}
