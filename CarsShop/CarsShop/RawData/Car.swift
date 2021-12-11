//
//  Car.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import Foundation

struct Car {
	let id = UUID()
	let name: String
	let startPrice: Double
	let body: [CarBody]
}
