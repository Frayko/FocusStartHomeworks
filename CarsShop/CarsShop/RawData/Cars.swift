//
//  Cars.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import Foundation

final class Cars {
	static let shared = Cars()
	private let cars: [Car]
	
	private init() {
		cars = [RawCars.bmw,
				RawCars.audi,
				RawCars.ford,
				RawCars.mazda,
				RawCars.honda]
	}
}

extension Cars {
	func getCars() -> [Car] {
		self.cars
	}
	
	func getCar(id: UUID) -> Car? {
		let car = self.cars.filter { $0.id == id }.first

		return car
	}
}
