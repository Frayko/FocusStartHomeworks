//
//  ListCarsPresenter.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import UIKit

protocol IListCarsPresenter {
	func loadView(controller: IListCarsVC, view: IListCarsView)
}

final class ListCarsPresenter {
	private let model: IListCarsModel
	//private let router: IListCarsRouter
	private let dataHandler: IListCarsDataHandler
	private weak var view: IListCarsView?
	private weak var controller: IListCarsVC?
	private var carsInstance: Cars
	
	struct Dependecies {
		let model: IListCarsModel
		let dataHandler: IListCarsDataHandler
		//let router: IListCarsRouter
	}
	
	init(dependecies: Dependecies) {
		self.model = dependecies.model
		self.dataHandler = dependecies.dataHandler
		self.carsInstance = Cars.shared
		//self.router = dependecies.router
	}
}

extension ListCarsPresenter: IListCarsPresenter {
	func loadView(controller: IListCarsVC, view: IListCarsView) {
		self.controller = controller
		self.view = view
		self.view?.setTableViewDelegate(delegate: self.dataHandler)
		self.view?.setTableViewDataSource(dataSource: self.dataHandler)
		self.view?.didLoad()
		
		self.setData()
		self.setHandlers()
	}
}

private extension ListCarsPresenter {
	func setData() {
		self.dataHandler.setCars(with: carsInstance.getCars())
		self.view?.reloadView()
	}
	
	func onTouched(id: UUID) {
		print("poop", id)
	}

	func setHandlers() {
		self.dataHandler.setOnTouchedButtonHandler { [weak self] id in
			self?.onTouched(id: id)
		}
	}
}
