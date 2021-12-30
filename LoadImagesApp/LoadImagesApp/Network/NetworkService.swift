//
//  NetworkService.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import Foundation

protocol INetworkService
{
	func loadImageFromURL(url: String)
	func setUpdateInfoHandler(_ handler: @escaping (([ImageURLModelDTO]) -> Void))
	func setCompletionFailureHandler(_ handler: @escaping ((String, String) -> Void))
	func setCompletionSuccessHandler(_ handler: @escaping ((Data) -> Void))
}

final class NetworkService: NSObject
{
	private var updateInfoHandler: (([ImageURLModelDTO]) -> Void)?
	private var completionFailureHandler: ((String, String) -> Void)?
	private var completionSuccessHandler: ((Data) -> Void)?
	
	private lazy var session: URLSession = {
		let configuration = URLSessionConfiguration.background(withIdentifier: "Background-Image-Loader")
		configuration.shouldUseExtendedBackgroundIdleMode = true
		configuration.waitsForConnectivity = true
		return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
	}()
	
	private lazy var downloadList = [ImageURLModelDTO]() {
		didSet {
			self.updateInfo(downloadList: self.downloadList)
		}
	}
}

extension NetworkService: INetworkService
{
	func setCompletionSuccessHandler(_ handler: @escaping ((Data) -> Void)) {
		self.completionSuccessHandler = handler
	}
	
	func setCompletionFailureHandler(_ handler: @escaping ((String, String) -> Void)) {
		self.completionFailureHandler = handler
	}
	
	func setUpdateInfoHandler(_ handler: @escaping (([ImageURLModelDTO]) -> Void)) {
		self.updateInfoHandler = handler
	}
	
	func loadImageFromURL(url: String) {
		guard let url = URL(string: url) else {
			self.completionFailure(title: "Ошибка до начала загрузки",
								   message: URLError.errorDomain)
			return
		}
		
		let downloadTask = self.session.downloadTask(with: url)
		self.downloadList.append(ImageURLModelDTO(url: url, downloadTask: downloadTask))
		downloadTask.resume()
	}
}

extension NetworkService: URLSessionDownloadDelegate
{
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		self.downloadList.removeAll { $0.downloadTask == downloadTask }
		self.updateInfo(downloadList: self.downloadList)
		guard let data = try? Data(contentsOf: location) else {
			self.completionFailure(title: "Ошибка загрузки",
									message: "По данной ссылке нет картинки")
			return
		}
		self.completionSuccess(data: data)
	}
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
		let downloadItem = self.downloadList.first { $0.downloadTask == downloadTask }
		
		downloadItem?.totalBytesWritten = totalBytesWritten
		downloadItem?.totalBytesExpectedToWrite = totalBytesExpectedToWrite
		self.updateInfo(downloadList: self.downloadList)
	}
	
	func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
		if let error = error {
			self.completionFailure(title: "Ошибка после загрузки",
								   message: error.localizedDescription)
		}
	}
	
	func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
		if let error = error {
			self.downloadList.removeAll { $0.downloadTask == task }
			self.completionFailure(title: "Ошибка после загрузки",
								   message: error.localizedDescription)
		}
	}
}

private extension NetworkService
{
	func updateInfo(downloadList: [ImageURLModelDTO]) {
		self.updateInfoHandler?(downloadList)
	}
	
	func completionFailure(title: String, message: String) {
		self.completionFailureHandler?(title, message)
	}
	
	func completionSuccess(data: Data) {
		self.completionSuccessHandler?(data)
	}
}
