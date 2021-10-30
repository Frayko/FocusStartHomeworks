//
//  MenuCars.swift
//  FirstHomework
//
//  Created by Александр Фомин on 30.10.2021.
//

import Foundation

class MenuCars {
	private var cars: [Car]
	
	init(cars: [Car] = []) {
		self.cars = cars
	}
	
	func start() {
		while true {
			printMenu()
			if let input = Int(readStrongLine()) {
				switch input {
				case 1:
					self.insert()
				case 2:
					self.printAllCars()
				case 3:
					printFiltredCars()
				case 0:
					return
				default:
					print("Ошибка при вводе пункта меню")
				}
			} else {
				print("Ошибка при вводе пункта меню")
			}
			print()
		}
	}
	
	private func printMenu() {
		print("""
			Меню:
			  1 - Добавить новый автомобиль
			  2 - Вывод списка добавленных автомобилей
			  3 - Вывод списка автомобилей с использованием фильтра по типу кузова
			  0 - Выход
			""")
	}
	
	private func insert() {
		print("Введите производителя")
		let manufacturer = readStrongLine()
		print("Введите модель")
		let model = readStrongLine()
		let body = readBody()
		print("Введите год производства (можно пропустить, нажав Enter)")
		let yearOfIssue = Int(readLine() ?? "")
		print("Введите гос. номер (можно пропустить, нажав Enter)")
		var carNumber = readLine()

		if carNumber == "" {
			carNumber = nil
		}

		self.cars.append(Car(manufacturer: manufacturer,
							 model: model, body: body,
							 yearOfIssue: yearOfIssue,
							 carNumber: carNumber))
	}
	
	private func readStrongLine() -> String {
		while true {
			if let input = readLine() {
				return input
			} else {
				print("Ошибка ввода, попробуйте ещё раз!")
			}
		}
	}
	
	private func printAllCars() {
		self.cars.forEach { print($0) }
	}
	
	private func readBody() -> Body {
		print(Body.allCases.map{ "\($0.rawValue) - \($0)" }.joined(separator: ", "))
		print("Введите тип кузова по номеру в списке:")

		while true {
			let bodyString = readStrongLine()
			if let body = Body(rawValue: Int(bodyString) ?? -1) {
				return body
			} else {
				print("Ошибка при выборе кузова, попробуйте ещё раз!")
			}
		}
	}
	
	private func printFiltredCars() {
		let body = readBody()
		self.cars.filter { $0.body == body }.forEach { print($0) }
	}
}
