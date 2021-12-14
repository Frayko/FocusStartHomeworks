//
//  ListCarsAssembly.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import UIKit

enum ListCarsAssembly
{
	static func build() -> UIViewController {
		let router = ListCarsRouter()
		let model = ListCarsModel()
		let dataHandler = ListCarsDataHandler()
		let presenter = ListCarsPresenter(dependecies: .init(model: model,
															 dataHandler: dataHandler,
															 router: router))
		let controller = ListCarsVC(presenter: presenter)
		return controller
	}
}
