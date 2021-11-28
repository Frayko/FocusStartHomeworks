//
//  AnimePageAssembly.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

enum AnimePageAssembly {
	static func build(animeIdentifier: UUID) -> UIViewController {
		let appRouter = AppRouter()
		let model = AnimePageModel()
		let presenter = AnimePagePresenter(dependecies: .init(model: model, appRouter: appRouter),
										   animeIdentifier: animeIdentifier)
		let controller = AnimePageVC(dependecies: .init(presenter: presenter))
		return controller
	}
}
