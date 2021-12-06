//
//  AnimePageVC.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

protocol IAnimePageVC: UIViewController {

}

final class AnimePageVC: UIViewController {
	private var rootView: IAnimePageView
	private var presenter: IAnimePagePresenter

	struct Dependecies {
		let presenter: IAnimePagePresenter
	}
	
	init(dependecies: Dependecies) {
		self.rootView = AnimePageView(frame: UIScreen.main.bounds)
		self.presenter = dependecies.presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		self.view = self.rootView
		self.presenter.loadView(controller: self, view: self.rootView)
		self.navigationItem.title = "Аниме"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.rootView.didLoad()
	}
}

extension AnimePageVC: IAnimePageVC {
	
}
