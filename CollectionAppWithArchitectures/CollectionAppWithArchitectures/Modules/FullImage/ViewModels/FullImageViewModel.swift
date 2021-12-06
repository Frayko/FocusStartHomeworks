//
//  FullImageViewModel.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

protocol IFullImageViewModel {
	func getImageName() -> Observable<String>
	func updateModel()
	func loadView()
}

final class FullImageViewModel {
	private var imageName: Observable<String> = Observable<String>("none")
	private let model: IFullImageModel
	private let animeIdentifier: UUID

	struct Dependencies {
		let model: IFullImageModel
	}
	
	init(dependencies: Dependencies, animeIdentifier: UUID) {
		self.model = dependencies.model
		self.animeIdentifier = animeIdentifier
	}
}

extension FullImageViewModel: IFullImageViewModel {
	func getImageName() -> Observable<String> {
		self.imageName
	}
	
	func updateModel() {
		self.imageName.data = "load"
		
		let randomTime = Int.random(in: 0...10)
		
		print("Loading time:", randomTime, "sec")
		
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(randomTime)) { [weak self] in
			self?.imageName.data = self?.model.getImageName() ?? "notFound"
		}
	}
	
	func loadView() {
		self.model.loadFullImageName(animeIdentifier: self.animeIdentifier)
		self.updateModel()
	}
}
