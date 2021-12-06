//
//  AnimePageView.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

protocol IAnimePageView: UIView {
	func didLoad()
	func setOnTouchedHandler(_ handler: @escaping (() -> Void))
	func setData(_ data: Anime)
}

final class AnimePageView: UIView {
	private var onTouchedHandler: (() -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
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
		let vStack = UIStackView(arrangedSubviews: [self.titleLabel,
													self.tagsLabel,
													self.openFullImageButton,
													self.descriptionTextView])
		
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
	
	private lazy var openFullImageButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Посмотреть постер", for: .normal)
		button.addTarget(self, action: #selector(self.touchedDown), for: .touchDown)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentMode = .scaleAspectFill
		return button
	}()
}

extension AnimePageView: IAnimePageView {
	func setOnTouchedHandler(_ handler: @escaping (() -> Void)) {
		self.onTouchedHandler = handler
	}
	
	func didLoad() {
		self.configureUI()
		self.configureView()
		self.configureScrollView()
	}
	
	func setData(_ data: Anime) {
		self.imageView.image = UIImage(named: data.imageName)
		self.titleLabel.text = data.title
		self.tagsLabel.text = ""
		for i in 0 ..< data.tags.count {
			self.tagsLabel.text?.append(contentsOf: data.tags[i])
			if i != data.tags.count - 1 {
				self.tagsLabel.text?.append(contentsOf: ", ")
			}
		}
		self.descriptionTextView.text = data.description
	}
}

private extension AnimePageView {
	@objc private func touchedDown() {
		self.onTouchedHandler?()
	}
	
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
			self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
			self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor)
		])
	
		NSLayoutConstraint.activate([
			self.stackView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
												constant: AnimePageLayout.stackViewTopAnchor),
			self.stackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
													constant: AnimePageLayout.stackViewLeadingAnchor),
			self.stackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
													 constant: AnimePageLayout.stackViewTrailingAnchor),
			self.stackView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
												   constant: AnimePageLayout.stackViewBottomAnchor)
		])
	}
	
	func configureScrollView() {
		let safeArea = self.safeAreaLayoutGuide
		self.addSubview(self.scrollView)

		NSLayoutConstraint.activate([
			self.scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor),
			self.scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			self.scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
			self.scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.topAnchor),
			self.scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.leadingAnchor),
			self.scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.trailingAnchor)
		])
	}
}

