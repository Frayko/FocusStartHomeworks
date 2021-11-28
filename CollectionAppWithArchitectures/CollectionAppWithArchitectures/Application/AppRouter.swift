//
//  AppRouter.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

protocol IAppRouter {
	func setController(controller: UIViewController)
	func setTargerController(controller: UIViewController)
	func next()
	func openModalView()
}

final class AppRouter {
	private var controller: UIViewController?
	private var targetController: UIViewController?
}

extension AppRouter: IAppRouter {
	func setController(controller: UIViewController) {
		self.controller = controller
	}
	
	func setTargerController(controller: UIViewController) {
		self.targetController = controller
	}
	
	func next() {
		guard let targetController = self.targetController else {
			return
		}
		
		self.controller?.navigationController?.pushViewController(targetController, animated: true)
	}
	
	func openModalView() {
		guard let targetController = self.targetController else {
			return
		}
		
		self.controller?.present(targetController, animated: true)
	}
}
