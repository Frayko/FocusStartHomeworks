//
//  AppRouter.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

final class AppRouter {
	private var controller: UIViewController?
	private var targetController: UIViewController?
	
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
