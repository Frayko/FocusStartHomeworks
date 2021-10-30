//
//  Car.swift
//  FirstHomework
//
//  Created by Александр Фомин on 30.10.2021.
//

import Foundation

struct Car: CustomStringConvertible {
	let manufacturer: String
	let model: String
	let body: Body
	let yearOfIssue: Int?
	let carNumber: String?
	
	var description: String {
		var str = "Производитель: \(self.manufacturer), модель: \(self.model), кузов: \(self.body)"
		
		if let year = yearOfIssue {
			str += ", год выпуска: \(year)"
		} else {
			str += ", год выпуска: -"
		}

		if let number = carNumber {
			str += ", гос. номер: \(number)"
		}
		
		return str
	}
}
