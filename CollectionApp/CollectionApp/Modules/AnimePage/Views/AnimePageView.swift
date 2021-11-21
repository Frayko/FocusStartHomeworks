//
//  AnimePageView.swift
//  CollectionApp
//
//  Created by Александр Фомин on 21.11.2021.
//

import UIKit

protocol IAnimePageView: UIView {
	func didLoad()
	func setImage(named: String)
	func setTitle(_ text: String)
	func setTags(_ tags: [String])
	func setDescription(_ text: String)
}

final class AnimePageView: UIView {
	private let screenSize = UIScreen.main.bounds
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.layer.masksToBounds = true
		return scrollView
	}()
	
	private lazy var imageView: UIImageView! = {
		let imageView : UIImageView!
		imageView = UIImageView(frame: self.bounds)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.center = self.center
		
		return imageView
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var tagsLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .title2)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var descriptionTextView: UITextView = {
		let textView = UITextView(frame: .zero, textContainer: nil)
		textView.backgroundColor = .quaternaryLabel
		textView.font = UIFont.preferredFont(forTextStyle: .title3)
		textView.layer.cornerRadius = AnimePageLayout.stackViewCornerRadius
		textView.layer.masksToBounds = true
		textView.textAlignment = .center
		textView.isEditable = false
		textView.isSelectable = true
		textView.isScrollEnabled = false
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
	}()
	
	private lazy var stackView: UIStackView = {
		let vStack = UIStackView(arrangedSubviews: [titleLabel, tagsLabel, descriptionTextView])
		
		vStack.axis = .vertical
		vStack.spacing = AnimePageLayout.stackViewSpacing
		vStack.backgroundColor = .systemBackground
		vStack.layer.borderWidth = AnimePageLayout.stackViewBorderWidth
		vStack.layer.borderColor = UIColor.white.cgColor
		vStack.alignment = .center
		vStack.layer.cornerRadius = AnimePageLayout.stackViewCornerRadius
		vStack.layer.masksToBounds = true
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		return vStack
	}()
}

extension AnimePageView: IAnimePageView {
	func didLoad() {
		configureUI()
		configureView()
		configureScrollView()
	}
	
	func setImage(named: String) {
		self.imageView.image = UIImage(named: named)
	}
	
	func resizeImageView(widthConstant: CGFloat, heightConstant: CGFloat) {
		NSLayoutConstraint.activate([
			imageView.heightAnchor.constraint(equalToConstant: heightConstant),
			imageView.widthAnchor.constraint(equalToConstant: widthConstant)
		])
	}
	
	
	func setTitle(_ text: String) {
		self.titleLabel.text = text
	}
	
	func setTags(_ tags: [String]) {
		self.tagsLabel.text = ""
		for i in 0 ..< tags.count {
			self.tagsLabel.text?.append(contentsOf: tags[i])
			if i != tags.count - 1 {
				self.tagsLabel.text?.append(contentsOf: ", ")
			}
		}
	}
	
	func setDescription(_ text: String) {
		self.descriptionTextView.text = text
	}
}

private extension AnimePageView {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureView() {
		self.addSubview(self.imageView)
		let scrollArea = self.scrollView.contentLayoutGuide
		self.scrollView.addSubview(self.stackView)

		NSLayoutConstraint.activate([
			self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
			self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
										   constant: AnimePageLayout.stackViewTopAnchor),
			stackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
											   constant: AnimePageLayout.stackViewLeadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
												constant: AnimePageLayout.stackViewTrailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
											  constant: AnimePageLayout.stackViewBottomAnchor)
		])
	}
	
	func configureScrollView() {
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
