//
//  AnimePagePresenter.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

protocol IAnimePagePresenter {
	func loadView(controller: IAnimePageVC, view: IAnimePageView)
}

final class AnimePagePresenter {
	private let model: IAnimePageModel
	private let appRouter: IAppRouter
	private weak var view: IAnimePageView?
	private weak var controller: IAnimePageVC?
	private let animeIdentifier: UUID
	
	struct Dependecies {
		let model: IAnimePageModel
		let appRouter: IAppRouter
	}
	
	init(dependecies: Dependecies, animeIdentifier: UUID) {
		self.model = dependecies.model
		self.appRouter = dependecies.appRouter
		self.animeIdentifier = animeIdentifier
	}
}

extension AnimePagePresenter: IAnimePagePresenter {
	func loadView(controller: IAnimePageVC, view: IAnimePageView) {
		self.controller = controller
		self.view = view
		
		self.model.loadAnime(animeIdentifier: self.animeIdentifier)
		self.setData()
		self.setHandlers()
	}
}

private extension AnimePagePresenter {
	func setData() {
		let modelViewAnime = self.model.getAnime()
		
		self.view?.setData(modelViewAnime)
	}
	
	func onTouched() {
		self.createModalFullImageView()
	}
	
	func createModalFullImageView() {
		let fullImageVC = FullImageAssembly.build(animeIdentifier: self.animeIdentifier)
		
		guard let controller = self.controller else {
			return
		}
		
		self.appRouter.setController(controller: controller)
		self.appRouter.setTargerController(controller: fullImageVC)
		self.appRouter.openModalView()
	}

	func setHandlers() {
		self.view?.setOnTouchedHandler { [weak self] in
			self?.onTouched()
		}
	}
}
