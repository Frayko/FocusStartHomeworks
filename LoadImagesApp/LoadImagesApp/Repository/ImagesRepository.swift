//
//  ImagesRepository.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

final class ImagesRepository
{
	static let shared = ImagesRepository()
	private var images: [UIImage]
	
	private init() {
		self.images = [UIImage]()
	}
}

extension ImagesRepository
{
	func append(_ image: UIImage) {
		self.images.append(image)
	}
	
	func getImages() -> [UIImage] {
		self.images
	}
}
