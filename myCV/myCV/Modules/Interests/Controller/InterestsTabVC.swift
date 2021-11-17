//
//  InterestsTabVC.swift
//  myCV
//
//  Created by Александр Фомин on 12.11.2021.
//

import UIKit

protocol IInterestsTabVC: UIViewController {
	func setInfo(_ text: String)
	func setImages(items: [String])
}

final class InterestsTabVC: UIViewController {
	private let rootView: IInterestsTabView = InterestsTabView()
	
	override func loadView() {
		self.view = self.rootView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Интересы"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.rootView.didLoad()
	}
}

extension InterestsTabVC: IInterestsTabVC {
	func setInfo(_ text: String) {
		rootView.setInfo(text)
	}
	
	func setImages(items: [String]) {
		rootView.setImages(items: items)
	}
}
