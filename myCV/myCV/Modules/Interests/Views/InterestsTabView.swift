//
//  InterestsTabView.swift
//  myCV
//
//  Created by Александр Фомин on 12.11.2021.
//

import UIKit

protocol IInterestsTabView: UIView {
	func didLoad()
	func setInfo(_ text: String)
	func setImages(items: [String])
}

final class InterestsTabView: UIView {
	private let screenSize = UIScreen.main.bounds
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.layer.masksToBounds = true
		return scrollView
	}()
	
	private lazy var infoLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var imageStackView: UIStackView = {
		let vStack = UIStackView()
		vStack.axis = .vertical
		vStack.spacing = InterestsTabLayout.photosStackViewSpacing
		vStack.alignment = .center
		vStack.translatesAutoresizingMaskIntoConstraints = false
		return vStack
	}()
}

extension InterestsTabView: IInterestsTabView {
	func didLoad() {
		configureUI()
		configureLayoutView()
		configureLayoutScrollView()
	}
	
	func setInfo(_ text: String) {
		self.infoLabel.text = text
	}
	
	func setImages(items: [String]) {
		for i in 0 ..< items.count {
			let imageView = buildImageView(items[i])
			self.imageStackView.addArrangedSubview(imageView)
		}
	}
	
	private func buildImageView(_ photoName: String) -> UIImageView {
		let image = UIImage(named: photoName)
		let imageView = UIImageView()
		imageView.image = image
		imageView.layer.cornerRadius = InterestsTabLayout.photoCornerRadius
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}
}

private extension InterestsTabView {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureLayoutView() {
		let scrollArea = scrollView.contentLayoutGuide
		self.scrollView.addSubview(self.infoLabel)
		self.scrollView.addSubview(self.imageStackView)
		
		NSLayoutConstraint.activate([
			self.infoLabel.topAnchor.constraint(equalTo: scrollArea.topAnchor,
												constant: InterestsTabLayout.scrollViewTopAnchor),
			self.infoLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
													constant: InterestsTabLayout.scrollViewLeadingAnchor),
			self.infoLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
													 constant: InterestsTabLayout.scrollViewTrailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			self.imageStackView.centerXAnchor.constraint(equalTo: scrollArea.centerXAnchor),
			self.imageStackView.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor,
													 constant: InterestsTabLayout.photoTopAnchor),
			self.imageStackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
														 constant: InterestsTabLayout.photoLeadingAnchor),
			self.imageStackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
														  constant: InterestsTabLayout.photoTrailingAnchor),
			self.imageStackView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
														constant: InterestsTabLayout.scrollViewBottomAnchor)
		])
	}
	
	func configureLayoutScrollView() {
		let safeArea = self.safeAreaLayoutGuide
		self.addSubview(scrollView)

		NSLayoutConstraint.activate([
			scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor),
			scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
			scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
			scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
			scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor)
		])
	}
}
