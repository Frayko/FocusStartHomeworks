//
//  ListCarsController.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import UIKit

protocol IListCarsVC: UIViewController {
	func pushDetailCar(id: UUID)
}

final class ListCarsVC: UIViewController {
	private let rootView: IListCarsView
	private let presenter: IListCarsPresenter
	
	init(presenter: IListCarsPresenter) {
		self.presenter = presenter
		self.rootView = ListCarsView()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = self.rootView
		self.presenter.loadView(controller: self, view: self.rootView)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Выберите"
	}
}

extension ListCarsVC: IListCarsVC {
	func pushDetailCar(id: UUID) {
		let detailCarVC = DetailCarAssembly.build(id: id)
		self.navigationController?.pushViewController(detailCarVC, animated: true)
	}
}
