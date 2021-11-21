//
//  AnimesController.swift
//  CollectionApp
//
//  Created by Александр Фомин on 20.11.2021.
//

import UIKit

final class AnimesController {
	func filteredAnimes(with filter: String?=nil, limit: Int?=nil) -> [Anime] {
		let filtered = animes.filter { $0.contains(filter) }
		if let limit = limit {
			return Array(filtered.prefix(through: limit))
		} else {
			return filtered
		}
	}
	private lazy var animes: [Anime] = {
		return generateAnimes()
	}()
}

extension AnimesController {
	func getAnime(at index: Int) -> Anime {
		animes[index]
	}
	
	func getAnimes() -> [Anime] {
		animes
	}
}

private extension AnimesController {
	func generateAnimes() -> [Anime] {
		let components = Animes.animeRawData.components(separatedBy: CharacterSet.newlines)
		var animes = [Anime]()
		
		for line in components {
			let animeComponents = line.components(separatedBy: ";")
			let imageName = animeComponents[0]
			let title = animeComponents[1]
			var tags = [String]()
			let tagComponents = animeComponents[2].components(separatedBy: ",")
			for tag in tagComponents {
				tags.append(tag)
			}
			let description = animeComponents[3]
			animes.append(Anime(imageName: imageName,
								title: title,
								tags: tags,
								description: description))
		}
		
		return animes
	}
}

