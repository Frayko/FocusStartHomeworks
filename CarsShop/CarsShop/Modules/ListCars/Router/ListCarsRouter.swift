//
//  ListCarsRouter.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

protocol IListCarsRouter {
	func setPushControllerHandler(_ handler: @escaping ((_ id: UUID) -> Void))
	func goToDetailCar(id: UUID)
}

final class ListCarsRouter {
	private var goToDetailCarHandler: ((_ id: UUID) -> Void)?
}

extension ListCarsRouter: IListCarsRouter {
	func setPushControllerHandler(_ handler: @escaping ((UUID) -> Void)) {
		self.goToDetailCarHandler = handler
	}
	
	func goToDetailCar(id: UUID) {
		self.goToDetailCarHandler?(id)
	}
}
