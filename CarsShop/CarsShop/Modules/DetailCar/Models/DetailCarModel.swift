//
//  DetailCarModel.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

protocol IDetailCarModel: AnyObject {
	func loadData(carId: UUID)
	func setData(car data: Car)
	func getData() -> Car
}

final class DetailCarModel {
	private var data: Car?
}

extension DetailCarModel: IDetailCarModel {
	func loadData(carId: UUID) {
		let carInstance = Cars.shared
		guard let rawCar = carInstance.getCar(id: carId) else { return }
		
		self.data = rawCar
	}
	
	func setData(car data: Car) {
		self.data = data
	}
	
	func getData() -> Car {
		guard let data = self.data else {
			return Car(name: "", startPrice: 0, body: [])
		}
		
		return data
	}
}
