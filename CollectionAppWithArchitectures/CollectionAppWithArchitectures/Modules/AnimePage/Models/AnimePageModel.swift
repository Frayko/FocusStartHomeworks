//
//  AnimePageModel.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import Foundation

protocol IAnimePageModel {
	func loadAnime(animeIdentifier: UUID)
	func getAnime() -> Anime
}

final class AnimePageModel {
	private var anime: Anime?
}

extension AnimePageModel: IAnimePageModel {
	func loadAnime(animeIdentifier: UUID) {
		self.anime = Animes.getAnime(animeIdentifier: animeIdentifier)
	}
	
	func getAnime() -> Anime {
		guard let anime = self.anime else {
			return Anime(imageName: "", title: "", tags: [""], description: "")
		}
		
		return anime
	}
}
