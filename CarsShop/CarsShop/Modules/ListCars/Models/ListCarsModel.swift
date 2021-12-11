//
//  ListCarsModel.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import UIKit

protocol IListCarsModel: AnyObject {
	func setData(car data: CarModel)
	func setData(car data: Car)
	func getData() -> CarModel
}

final class ListCarsModel {
	private var data: CarModel?
}

extension ListCarsModel: IListCarsModel {
	func setData(car data: CarModel) {
		self.data = data
	}
	
	func setData(car data: Car) {
		let carModel = CarModel(id: data.id, name: data.name)
		self.data = carModel
	}
	
	func getData() -> CarModel {
		guard let data = self.data else {
			return CarModel(id: UUID(), name: "")
		}
		
		return data
	}
}
