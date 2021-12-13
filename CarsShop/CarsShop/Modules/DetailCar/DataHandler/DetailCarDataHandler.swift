//
//  DetailCarDataHandler.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

protocol IDetailCarDataHandler: UITableViewDelegate, UITableViewDataSource {
	func setCarBody(with carBody: [CarBody])
	func setOnTouchedButtonHandler(_ handler: @escaping ((_ carBodyImageName: String) -> Void))
	func getRowSelected() -> Int
}

final class DetailCarDataHandler: NSObject {
	private var carBody: [CarBody]?
	private var onTouchedButtonHandler: ((_ carBodyImageName: String) -> Void)?
	private var rowSelected = 0
}

extension DetailCarDataHandler: IDetailCarDataHandler {
	func setCarBody(with carBody: [CarBody]) {
		self.carBody = carBody
	}
	
	func setOnTouchedButtonHandler(_ handler: @escaping ((_ carBodyImageName: String) -> Void)) {
		self.onTouchedButtonHandler = handler
	}
	
	func getRowSelected() -> Int {
		self.rowSelected
	}
}

extension DetailCarDataHandler: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let carBody = self.carBody?[indexPath.item] else {
			return
		}
		
		rowSelected = indexPath.item
		
		self.onTouchedButtonHandler?(carBody.rawValue.imageName)
	}
}

extension DetailCarDataHandler: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.carBody?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DetailCarViewCell.identifier, for: indexPath) as! DetailCarViewCell
		
		guard let carBody = self.carBody?[indexPath.item] else {
			return cell
		}
		
		if indexPath.item == 0 {
			tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
		}
		
		cell.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
		cell.selectionStyle = .none
		
		cell.setData(with: carBody)
		return cell
	}
}
