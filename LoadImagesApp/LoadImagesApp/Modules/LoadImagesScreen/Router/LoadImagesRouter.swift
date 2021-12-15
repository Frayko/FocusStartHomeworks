//
//  LoadImagesRouter.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 15.12.2021.
//

import Foundation

protocol ILoadImagesRouter
{
	func setGoToShowAlertMessageHandler(_ handler: @escaping ((_ title: String, _ message: String) -> Void))
	func goToShowAlertMessage(title: String, message: String)
}

final class LoadImagesRouter
{
	private var goToShowAlertMessageHandler: ((_ title: String, _ message: String) -> Void)?
}

extension LoadImagesRouter: ILoadImagesRouter
{
	func setGoToShowAlertMessageHandler(_ handler: @escaping ((_ title: String, _ message: String) -> Void)) {
		self.goToShowAlertMessageHandler = handler
	}
	
	func goToShowAlertMessage(title: String, message: String) {
		self.goToShowAlertMessageHandler?(title, message)
	}
}
