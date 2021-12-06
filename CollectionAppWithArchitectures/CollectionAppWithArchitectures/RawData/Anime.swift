//
//  Anime.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import Foundation

struct Anime {
	let imageName: String
	let title: String
	let tags: [String]
	let description: String
	let identifier = UUID()
}
