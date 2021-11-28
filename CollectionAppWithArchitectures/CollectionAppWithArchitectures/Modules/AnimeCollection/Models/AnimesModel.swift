//
//  AnimesModel.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 27.11.2021.
//

import UIKit

final class AnimesModel {
	func filteredAnimes(with filter: String?=nil, limit: Int?=nil) -> [AnimeModel] {
		let filtered = animes.filter { $0.contains(filter) }
		if let limit = limit {
			return Array(filtered.prefix(through: limit))
		} else {
			return filtered
		}
	}
	private lazy var animes: [AnimeModel] = {
		return generateAnimes()
	}()
}

private extension AnimesModel {
	func generateAnimes() -> [AnimeModel] {
		let rawAnimes = Animes.getAnimes()
		var animes = [AnimeModel]()
		
		for i in 0 ..< rawAnimes.count {
			animes.append(AnimeModel(imageName: rawAnimes[i].imageName,
									 title: rawAnimes[i].title,
									 identifier: rawAnimes[i].identifier))
		}
		
		return animes
	}
}
