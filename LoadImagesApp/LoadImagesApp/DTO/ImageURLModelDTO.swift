//
//  ImageURLModelDTO.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import Foundation

final class ImageURLModelDTO
{
	let id = UUID()
	let url: URL
	let downloadTask: URLSessionDownloadTask
	
	var totalBytesWritten: Int64?
	var totalBytesExpectedToWrite: Int64?
	
	init(url: URL, downloadTask: URLSessionDownloadTask) {
		self.url = url
		self.downloadTask = downloadTask
	}
}
