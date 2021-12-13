//
//  DetailCarRouter.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import Foundation

protocol IDetailCarRouter {
	func setGoToListCarsHandler(_ handler: @escaping (() -> Void))
	func goToListCars()
}

final class DetailCarRouter {
	private var goToListCarsHandler: (() -> Void)?
}

extension DetailCarRouter: IDetailCarRouter {
	func setGoToListCarsHandler(_ handler: @escaping (() -> Void)) {
		self.goToListCarsHandler = handler
	}
	
	func goToListCars() {
		self.goToListCarsHandler?()
	}
}
