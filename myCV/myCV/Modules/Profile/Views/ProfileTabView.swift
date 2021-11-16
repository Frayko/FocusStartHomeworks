//
//  ProfileTabView.swift
//  myCV
//
//  Created by Александр Фомин on 12.11.2021.
//

import UIKit

protocol IProfileTabView: UIView {
	func didLoad()
	func setFullName(_ text: String)
	func setAge(_ age: Int)
	func setDescription(_ text: String)
}

final class ProfileTabView: UIView {
	private lazy var photoImageView: UIImageView = {
		let image = UIImage(named: "photo")
		let imageView = UIImageView()
		imageView.image = image
		imageView.contentMode = .scaleAspectFit
		imageView.layer.borderWidth = 2.0
		imageView.layer.masksToBounds = true
		imageView.layer.borderColor = UIColor.red.cgColor
		imageView.layer.cornerRadius = ProfileTabLayout.imageViewCornerRadius
		imageView.clipsToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	private lazy var fullNameLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = UIColor.systemBackground
		label.font = UIFont.systemFont(ofSize: 22)
		label.contentMode = .scaleAspectFill
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var ageLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = UIColor.systemBackground
		label.font = UIFont.systemFont(ofSize: 22)
		label.contentMode = .scaleAspectFill
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var descriptionTextView: UITextView = {
		let textView = UITextView(frame: .zero, textContainer: nil)
		textView.backgroundColor = UIColor.systemBackground
		textView.font = UIFont.systemFont(ofSize: 14)
		textView.textAlignment = .justified
		textView.textColor = UIColor.label
		textView.isEditable = false
		textView.isSelectable = true
		textView.isScrollEnabled = false
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
	}()
}

extension ProfileTabView : IProfileTabView {
	func didLoad() {
		configureUI()
		configureLayout()
	}
	
	func setFullName(_ text: String) {
		self.fullNameLabel.text = text
	}

	func setAge(_ age: Int) {
		self.ageLabel.text = String(age) + " год"
	}

	func setDescription(_ text: String) {
		self.descriptionTextView.text = text
	}
}

private extension ProfileTabView {
	func configureUI() {
		self.backgroundColor = UIColor.systemBackground
	}
	
	func configureLayout() {
		self.addSubview(photoImageView)
		self.addSubview(fullNameLabel)
		self.addSubview(ageLabel)
		self.addSubview(descriptionTextView)
		
		NSLayoutConstraint.activate([
			self.photoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor,
														 constant: -(self.bounds.height / 4)),
			self.photoImageView.heightAnchor.constraint(equalToConstant: self.bounds.width / 100 * 50),
			self.photoImageView.widthAnchor.constraint(equalToConstant: self.bounds.width / 100 * 50)
		])

		NSLayoutConstraint.activate([
			self.fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.fullNameLabel.topAnchor.constraint(equalTo: self.photoImageView.bottomAnchor,
													constant: ProfileTabLayout.topAnchorLabel)
		])
		
		NSLayoutConstraint.activate([
			self.ageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.ageLabel.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor,
											   constant: ProfileTabLayout.topAnchorLabel)
		])
		
		NSLayoutConstraint.activate([
			self.descriptionTextView.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor,
														  constant: ProfileTabLayout.topAnchorText),
			self.descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
															  constant: ProfileTabLayout.leadingAnchorText),
			self.descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
															   constant: ProfileTabLayout.trailingAnchorText)
		])
	}
}
