//
//  LoadImagesVC.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

protocol ILoadImagesVC: UIViewController
{
	func showAlertMessage(title: String, message: String)
}

final class LoadImagesVC: UIViewController
{
	private let rootView: ILoadImagesView
	private let presenter: ILoadImagesPresenter
	
	init(presenter: ILoadImagesPresenter) {
		self.presenter = presenter
		self.rootView = LoadImagesView()
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

extension LoadImagesVC: ILoadImagesVC
{
	func showAlertMessage(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let okAction = UIAlertAction(title: "OK", style: .default) { action in
			self.dismiss(animated: true)
		}
		alert.addAction(okAction)
		
		self.present(alert, animated: true)
	}
}
