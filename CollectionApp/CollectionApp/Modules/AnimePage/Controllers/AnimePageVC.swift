//
//  AnimePageVC.swift
//  CollectionApp
//
//  Created by Александр Фомин on 21.11.2021.
//

import UIKit

protocol IAnimePageVC: UIViewController {
	func setImage(named: String)
	func setTitle(_ text: String)
	func setTags(_ tags: [String])
	func setDescription(_ text: String)
}

final class AnimePageVC: UIViewController {
	private let rootView: IAnimePageView = AnimePageView()
	
	override func loadView() {
		self.view = self.rootView
		self.navigationItem.title = "Аниме"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.rootView.didLoad()
		configureOpenFullImageButton()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}

extension AnimePageVC: IAnimePageVC {
	func setImage(named: String) {
		self.rootView.setImage(named: named)
	}
	
	func setTitle(_ text: String) {
		self.rootView.setTitle(text)
	}
	
	func setTags(_ tags: [String]) {
		self.rootView.setTags(tags)
	}
	
	func setDescription(_ text: String) {
		self.rootView.setDescription(text)
	}
}

private extension AnimePageVC {
	func configureOpenFullImageButton() {
		self.rootView.addOpenFullImageButtonTarget(self, action: #selector(openFullImage))
	}
	
	@objc func openFullImage() {
		let fullImageVC: IFullImageVC = FullImageVC()
		fullImageVC.setImage(self.rootView.image)
		present(fullImageVC, animated: true, completion: nil)
	}
}
