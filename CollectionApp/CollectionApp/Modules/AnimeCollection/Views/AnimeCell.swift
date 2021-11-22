//
//  AnimeCell.swift
//  CollectionApp
//
//  Created by Александр Фомин on 20.11.2021.
//

import UIKit

final class AnimeCell: UICollectionViewCell {
	static let reuseIdentifier = "anime-cell-reuse-identifier"
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleToFill
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = AnimeCollectionLayout.animeCellImageCornerRadius
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var title: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .center
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}
	required init?(coder: NSCoder) {
		fatalError("not implemented")
	}
}

extension AnimeCell {
	func setImage(named: String) {
		self.imageView.image = UIImage(named: named)
	}
	
	func setTitle(_ text: String) {
		self.title.text = text
	}
}

private extension AnimeCell {
	func configureView() {
		contentView.addSubview(self.imageView)
		
		NSLayoutConstraint.activate([
			self.imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			self.imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor,
												   constant: AnimeCollectionLayout.animeCellImageHeigth),
			self.imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor,
												  constant: AnimeCollectionLayout.animeCellImageWidth),
			self.imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
		
		contentView.addSubview(self.title)
		
		NSLayoutConstraint.activate([
			self.title.topAnchor.constraint(equalTo: self.imageView.bottomAnchor,
											constant: AnimeCollectionLayout.animeCellBottomAnchor),
			self.title.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor,
												constant: AnimeCollectionLayout.animeCellLeadingAnchor),
			self.title.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor,
												 constant: AnimeCollectionLayout.animeCellTrailingAnchor)
			])
	}
}
