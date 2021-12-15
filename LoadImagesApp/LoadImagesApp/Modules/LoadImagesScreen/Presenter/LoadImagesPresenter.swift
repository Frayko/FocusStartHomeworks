//
//  LoadImagesPresenter.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

protocol ILoadImagesPresenter
{
	func loadView(controller: ILoadImagesVC, view: ILoadImagesView)
}

final class LoadImagesPresenter
{
	private let network: INetworkService
	private let router: ILoadImagesRouter
	private let dataHandler: ILoadImagesDataHandler
	private weak var view: ILoadImagesView?
	private weak var controller: ILoadImagesVC?
	private var imagesReposity: ImagesRepository
	
	struct Dependecies {
		let dataHandler: ILoadImagesDataHandler
		let network: INetworkService
		let router: ILoadImagesRouter
	}
	
	init(dependecies: Dependecies) {
		self.dataHandler = dependecies.dataHandler
		self.imagesReposity = ImagesRepository.shared
		self.network = dependecies.network
		self.router = dependecies.router
	}
}

extension LoadImagesPresenter: ILoadImagesPresenter
{
	func loadView(controller: ILoadImagesVC, view: ILoadImagesView) {
		self.controller = controller
		self.view = view
		self.view?.setTableViewDelegate(delegate: self.dataHandler)
		self.view?.setTableViewDataSource(dataSource: self.dataHandler)
		self.view?.setSearchBarDelegate(delegate: self.dataHandler)
		self.view?.didLoad()
		
		self.setData()
		self.setHandlers()
	}
}

private extension LoadImagesPresenter
{
	func setData() {
		self.dataHandler.setImages(self.imagesReposity.getImages())
		self.view?.reloadView()
	}

	func setHandlers() {
		self.dataHandler.setOnRequestTextHandler { [weak self] url in
			self?.network.loadImageFromURL(url: url)
		}
		
		self.network.setCompletionFailureHandler { title, message in
			DispatchQueue.main.async {
				self.router.goToShowAlertMessage(title: title, message: message)
			}
		}
		
		self.network.setCompletionSuccessHandler { data in
			guard let image = UIImage(data: data) else {
				DispatchQueue.main.async {
					self.router.goToShowAlertMessage(title: "Ошибка при загрузке",
													 message: "По данной ссылке нет картинки")
				}
				return
			}
			
			self.imagesReposity.append(image)
			DispatchQueue.main.async {
				self.dataHandler.setImages(self.imagesReposity.getImages())
				self.view?.reloadView()
			}
		}
		
		self.network.setUpdateInfoHandler { imagesInfo in
			var countBytesDownload: Float = 0
			var countBytesAll: Float = 0
			
			for imageInfo in imagesInfo {
				countBytesDownload += Float(imageInfo.totalBytesWritten ?? 0)
				countBytesAll += Float(imageInfo.totalBytesExpectedToWrite ?? 0)
			}
			
			countBytesAll = countBytesAll / 1024.0 / 1024.0
			countBytesDownload = countBytesDownload / 1024.0 / 1024.0
			
			let data = LoadImagesStatsModel(countDownloads: imagesInfo.count,
											totalBytesWritten: countBytesDownload,
											totalBytesExpectedToWrite: countBytesAll)
			DispatchQueue.main.async {
				self.view?.setProgressData(data: data)
			}
		}
		
		self.router.setGoToShowAlertMessageHandler { title, message in
			self.controller?.showAlertMessage(title: title, message: message)
		}
	}
}
