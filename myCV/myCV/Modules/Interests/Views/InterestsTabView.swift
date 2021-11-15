//
//  InterestsTabView.swift
//  myCV
//
//  Created by Александр Фомин on 12.11.2021.
//

import UIKit

protocol IInterestsTabView: UIView {
	func didLoad()
}

final class InterestsTabView: UIView {
	private let screenSize = UIScreen.main.bounds
}

extension InterestsTabView: IInterestsTabView {
	func didLoad() {
		configureUI()
		configureLayout()
	}
}

private extension InterestsTabView {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureLayout() {
		
	}
}
