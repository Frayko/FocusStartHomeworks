//
//  DetailCarAssembly.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

enum DetailCarAssembly {
	static func build(id: UUID) -> UIViewController {
		let router = DetailCarRouter()
		let model = DetailCarModel()
		let dataHandler = DetailCarDataHandler()
		let presenter = DetailCarPresenter(dependecies: .init(model: model,
															  dataHandler: dataHandler,
															  router: router),
										   carID: id)
		let controller = DetailCarVC(presenter: presenter)
		return controller
	}
}
