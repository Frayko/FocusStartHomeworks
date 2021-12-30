//
//  DetailCarController.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

protocol IDetailCarVC: UIViewController
{
	func goToListCars()
}

final class DetailCarVC: UIViewController
{
	private let rootView: IDetailCarView
	private let presenter: IDetailCarPresenter
	
	init(presenter: IDetailCarPresenter) {
		self.presenter = presenter
		self.rootView = DetailCarView()
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
	}
}

extension DetailCarVC: IDetailCarVC
{
	func goToListCars() {
		self.navigationController?.popToRootViewController(animated: true)
	}
}
