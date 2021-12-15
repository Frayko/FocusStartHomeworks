//
//  LoadImagesAssembly.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

enum LoadImagesAssembly
{
	static func build() -> UIViewController {
		let router = LoadImagesRouter()
		let network = NetworkService()
		let dataHandler = LoadImagesDataHandler()
		let presenter = LoadImagesPresenter(dependecies: .init(dataHandler: dataHandler,
															   network: network,
															   router: router))
		let controller = LoadImagesVC(presenter: presenter)
		return controller
	}
}
