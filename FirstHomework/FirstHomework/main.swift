//
//  main.swift
//  FirstHomework
//
//  Created by Александр Фомин on 29.10.2021.
//

import Foundation

let cars: [Car] =
		[Car(manufacturer: "Toyota",
			 model: "Wish",
			 body: .minivan,
			 yearOfIssue: 2003,
			 carNumber: nil),
		 
		 Car(manufacturer: "Mercedes",
			 model: "C-Class",
			 body: .sedan,
			 yearOfIssue: 2021,
			 carNumber: nil),
		 
		 Car(manufacturer: "УАЗ",
			 model: "Pickup Classic",
			 body: .pickup,
			 yearOfIssue: 2006,
			 carNumber: "a000bc")]

let menu = MenuCars(cars: cars)

menu.start()
