//
//  FullImageAssembly.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

enum FullImageAssembly {
	static func build(animeIdentifier: UUID) -> UIViewController {
		let model = FullImageModel()
		let viewModel = FullImageViewModel(dependencies: .init(model: model),
										   animeIdentifier: animeIdentifier)
		let controller = FullImageVC(dependecies: .init(viewModel: viewModel))
		return controller
	}
}
