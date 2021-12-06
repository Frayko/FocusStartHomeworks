//
//  AnimeModel.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 27.11.2021.
//

import Foundation

struct AnimeModel {
	let imageName: String
	let title: String
	let identifier: UUID
	
	func contains(_ filter: String?) -> Bool {
		guard let filterText = filter else { return true }
		if filterText.isEmpty { return true }
		let lowercasedFilter = filterText.lowercased()
		return title.lowercased().contains(lowercasedFilter)
	}
}

extension AnimeModel: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}
}

extension AnimeModel: Equatable {
	static func == (lhs: AnimeModel, rhs: AnimeModel) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}
