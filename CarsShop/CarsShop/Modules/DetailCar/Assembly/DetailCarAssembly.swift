//
//  DetailCarAssembly.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

enum DetailCarAssembly {
	static func build(id: UUID) -> UIViewController {
		//let router = DetailCarRouter()
		//let model = DetailCarModel()
		//let dataHandler = DetailCarDataHandler(model: model)
		//let presenter = DetailCarPresenter(dependecies: .init(model: model,
		//													 dataHandler: dataHandler))
		//let controller = DetailCarVC(presenter: presenter)
		print("poop", id)
		let controller = UIViewController()
		return controller
	}
}
