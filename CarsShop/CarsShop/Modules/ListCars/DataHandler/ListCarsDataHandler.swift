//
//  ListCarsDataHandler.swift
//  CarsShop
//
//  Created by Александр Фомин on 11.12.2021.
//

import UIKit

protocol IListCarsDataHandler: UITableViewDelegate, UITableViewDataSource {
	func setCars(with cars: [Car])
	func setOnTouchedButtonHandler(_ handler: @escaping ((_ id: UUID) -> Void))
}

final class ListCarsDataHandler: NSObject {
	private var cars: [Car]?
	private weak var model: IListCarsModel?
	private var onTouchedButtonHandler: ((_ id: UUID) -> Void)?
	
	init(model: IListCarsModel) {
		self.model = model
	}
}

extension ListCarsDataHandler: IListCarsDataHandler {
	func setCars(with cars: [Car]) {
		self.cars = cars
	}
	
	func setOnTouchedButtonHandler(_ handler: @escaping ((_ id: UUID) -> Void)) {
		self.onTouchedButtonHandler = handler
	}
}

extension ListCarsDataHandler: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let car = self.cars?[indexPath.item] else {
			return
		}
		
		self.onTouchedButtonHandler?(car.id)
	}
}

extension ListCarsDataHandler: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.cars?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ListCarsViewCell.identifier, for: indexPath) as! ListCarsViewCell
		
		guard
			let model = self.model,
			let car = self.cars?[indexPath.item]
		else {
			return cell
		}
		
		model.setData(car: car)
		let carData = model.getData()
		
		cell.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
		
		if indexPath.item % 2 == 0 {
			cell.setImageColor(ListCarsColors.cellImageViewEvenColor)
		}
		else {
			cell.setImageColor(ListCarsColors.cellImageViewOddColor)
		}
		
		cell.setData(car: carData)
		return cell
	}
}
