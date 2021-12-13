//
//  DetailCarPresenter.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

protocol IDetailCarPresenter {
	func loadView(controller: IDetailCarVC, view: IDetailCarView)
}

final class DetailCarPresenter {
	private let model: IDetailCarModel
	private let router: IDetailCarRouter
	private let dataHandler: IDetailCarDataHandler
	private weak var view: IDetailCarView?
	private weak var controller: IDetailCarVC?
	private var carID: UUID
	
	struct Dependecies {
		let model: IDetailCarModel
		let dataHandler: IDetailCarDataHandler
		let router: IDetailCarRouter
	}
	
	init(dependecies: Dependecies, carID: UUID) {
		self.model = dependecies.model
		self.dataHandler = dependecies.dataHandler
		self.router = dependecies.router
		self.carID = carID
	}
	
	private lazy var returnButton: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(close))
		return button
	}()
}

extension DetailCarPresenter: IDetailCarPresenter {
	func loadView(controller: IDetailCarVC, view: IDetailCarView) {
		self.controller = controller
		self.controller?.navigationItem.leftBarButtonItem = returnButton
		self.view = view
		self.view?.setTableViewDelegate(delegate: self.dataHandler)
		self.view?.setTableViewDataSource(dataSource: self.dataHandler)
		self.view?.didLoad()
		
		self.model.loadData(carId: self.carID)
		
		self.setData()
		self.setHandlers()
	}
}

private extension DetailCarPresenter {
	@objc func close() {
		self.controller?.goToListCars()
	}
	
	func setData() {
		let car = self.model.getData()
		
		if car.body.count > 0 {
			let defaultBody = car.body[0].rawValue
			self.view?.setCarImageName(defaultBody.imageName)
			self.view?.setPrice(car.startPrice + defaultBody.cost)
		}
		self.dataHandler.setCarBody(with: car.body)
		self.view?.reloadView()
	}
	
	func updateImage(carBodyImageName: String) {
		self.view?.setCarImageName(carBodyImageName)
	}
	
	func updatePrice() {
		let car = self.model.getData()
		let rowSelected = self.dataHandler.getRowSelected()
		
		guard car.body.count > rowSelected else { return }
		
		self.view?.setPrice(car.startPrice + car.body[rowSelected].rawValue.cost)
	}

	func setHandlers() {
		self.view?.setOnTouchedButtonHandler { [weak self] in
			self?.updatePrice()
		}
		
		self.dataHandler.setOnTouchedButtonHandler { [weak self] carBodyImageName in
			self?.updateImage(carBodyImageName: carBodyImageName)
		}
		
		self.router.setGoToListCarsHandler { [weak self] in
			self?.controller?.goToListCars()
		}
	}
}
