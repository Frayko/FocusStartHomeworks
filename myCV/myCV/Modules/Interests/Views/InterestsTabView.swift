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
	
	private lazy var infoTextView: UITextView = {
		let textView = UITextView(frame: .zero, textContainer: nil)
		textView.backgroundColor = UIColor.systemBackground
		textView.font = UIFont.systemFont(ofSize: 16)
		textView.textAlignment = .left
		textView.textColor = UIColor.label
		textView.isEditable = false
		textView.isSelectable = true
		textView.isScrollEnabled = false
		textView.layer.cornerRadius = InterestsTabLayout.textCornerRadius
		textView.backgroundColor = .lightText
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
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
		self.infoTextView.text = text
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
		imageView.layer.masksToBounds = true
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		let height = imageView.image?.size.height ?? 0
		let width = imageView.image?.size.width ?? 0
		let ratio = height / width
		let widthAnchor = screenSize.width - (InterestsTabLayout.photoLeadingAnchor * 2)
		let heightAnchor = ratio * widthAnchor
		
		NSLayoutConstraint.activate([
			imageView.heightAnchor.constraint(equalToConstant: heightAnchor),
			imageView.widthAnchor.constraint(equalToConstant: widthAnchor)
		])
		
		return imageView
	}
}

private extension InterestsTabView {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureLayoutView() {
		let scrollArea = scrollView.contentLayoutGuide
		self.scrollView.addSubview(self.infoTextView)
		self.scrollView.addSubview(self.imageStackView)
		
		NSLayoutConstraint.activate([
			self.infoTextView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
												constant: InterestsTabLayout.scrollViewTopAnchor),
			self.infoTextView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
													constant: InterestsTabLayout.scrollViewLeadingAnchor),
			self.infoTextView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
													 constant: InterestsTabLayout.scrollViewTrailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			self.imageStackView.centerXAnchor.constraint(equalTo: scrollArea.centerXAnchor),
			self.imageStackView.topAnchor.constraint(equalTo: self.infoTextView.bottomAnchor,
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
