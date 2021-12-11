//
//  CarBody.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import Foundation

enum CarBody {
	case sedan(String, Double)
	case coupe(String, Double)
	case universal(String, Double)
	case hatchback(String, Double)
	
	var rawValue: (name: String, imageName: String, cost: Double) {
		switch self {
		case .sedan(let imageName, let cost): return ("Седан", imageName, cost)
		case .coupe(let imageName, let cost): return ("Купе", imageName, cost)
		case .universal(let imageName, let cost): return ("Универсал", imageName, cost)
		case .hatchback(let imageName, let cost): return ("Хэтчбек", imageName, cost)
		}
	}
}
