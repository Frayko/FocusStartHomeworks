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
					print("\(Body.getAllCases)\nВведите тип кузова по номеру в списке:")
					let body = readStrongLine()
					
					guard let bodyNumber = Body(rawValue: Int(body) ?? -1) else {
						print("Ошибка при выборе кузова")
						break
					}
					
					print()
					print("Результат")
					
					printFiltredCars(body: bodyNumber)
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
		print("\(Body.getAllCases)\nВведите тип кузова по номеру в списке")
		let body = readStrongLine()
		print("Введите год производства (можно пропустить, нажав Enter)")
		let yearOfIssue = Int(readLine() ?? "")
		print("Введите гос. номер (можно пропустить, нажав Enter)")
		var carNumber = readLine()

		if carNumber == "" {
			carNumber = nil
		}

		guard let bodyNumber = Body(rawValue: Int(body) ?? -1) else {
			print("Ошибка при выборе кузова")
			return
		}

		self.cars.append(Car(manufacturer: manufacturer, model: model, body: bodyNumber, yearOfIssue: yearOfIssue, carNumber: carNumber))
	}
	
	private func readStrongLine() -> String {
		guard let input = readLine() else {
			print("Ошибка при вводе данных")
			return ""
		}
		
		return input
	}
	
	private func printAllCars() {
		self.cars.forEach { print($0.fullDescription) }
	}
	
	private func printFiltredCars(body: Body) {
		self.cars.forEach { car in
			if car.body == body {
				print(car.fullDescription)
			}
		}
	}
}
