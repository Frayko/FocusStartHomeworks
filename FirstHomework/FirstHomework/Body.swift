//
//  Body.swift
//  FirstHomework
//
//  Created by Александр Фомин on 30.10.2021.
//

import Foundation

enum Body: Int {
	case sedan
	case minivan
	case hatchback
	case cabriolet
	case pickup
	
	static func printAllCases() {
		print("Доступные кузова: 1 - Седан, 2 - Минивэн, 3 - Хэтчбек, 4 - Кабриолет, 5 - Пикап")
	}
}
