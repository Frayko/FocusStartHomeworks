//
//  RawCars.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

enum RawCars
{
	static let bmw = Car(name: "BMW",
						 startPrice: 10000,
						 body: [
							.sedan("bmw_sedan", 5000),
							.coupe("bmw_coupe", 3000),
							.universal("bmw_universal", 4000),
							.hatchback("bmw_hatchback", 2000)
						 ])
	
	static let audi = Car(name: "Audi",
						  startPrice: 15000,
						  body: [
							.sedan("audi_sedan", 4000),
							.coupe("audi_coupe", 5000),
							.universal("audi_universal", 2000),
							.hatchback("audi_hatchback", 3000)
						  ])
	
	static let ford = Car(name: "Ford",
						  startPrice: 17500,
						  body: [
							.sedan("ford_sedan", 2000),
							.coupe("ford_coupe", 6000),
							.universal("ford_universal", 3000),
							.hatchback("ford_hatchback", 4000)
						  ])
	
	static let mazda = Car(name: "Mazda",
						  startPrice: 12500,
						  body: [
							.sedan("mazda_sedan", 4000),
							.coupe("mazda_coupe", 5000),
							.universal("mazda_universal", 2000),
							.hatchback("mazda_hatchback", 3000)
						  ])
	
	static let honda = Car(name: "Honda",
						  startPrice: 13500,
						  body: [
							.sedan("honda_sedan", 2000),
							.coupe("honda_coupe", 6000),
							.universal("honda_universal", 5000),
							.hatchback("honda_hatchback", 2000)
						  ])
}
