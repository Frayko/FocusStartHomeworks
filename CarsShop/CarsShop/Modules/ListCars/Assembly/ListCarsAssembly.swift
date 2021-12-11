//
//  ListCarsAssembly.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import UIKit

enum ListCarsAssembly {
	static func build() -> UIViewController {
		//let appRouter = AppRouter()
		let model = ListCarsModel()
		let dataHandler = ListCarsDataHandler(model: model)
		let presenter = ListCarsPresenter(dependecies: .init(model: model,
															 dataHandler: dataHandler))
		let controller = ListCarsVC(presenter: presenter)
		return controller
	}
}
