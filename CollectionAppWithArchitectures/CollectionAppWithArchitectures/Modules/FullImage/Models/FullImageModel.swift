//
//  FullImageModel.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import Foundation

protocol IFullImageModel {
	func getImageName() -> String
	func loadFullImageName(animeIdentifier: UUID)
}

final class FullImageModel {
	private var imageName: String?
}

extension FullImageModel: IFullImageModel {
	func loadFullImageName(animeIdentifier: UUID) {
		self.imageName = Animes.getAnimeImageName(animeIdentifier: animeIdentifier)
	}
	
	func getImageName() -> String {
		guard let imageName = self.imageName else {
			return "notFound"
		}
		
		return imageName
	}
}
