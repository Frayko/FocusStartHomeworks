//
//  ProfileTabView.swift
//  myCV
//
//  Created by Александр Фомин on 12.11.2021.
//

import UIKit

protocol IProfileTabView: UIView {
	func didLoad()
	func setPhoto(named: String)
	func setFullName(_ text: String)
	func setAge(_ age: Int)
	func setDescription(_ text: String)
}

final class ProfileTabView: UIView {
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.layer.masksToBounds = true
		return scrollView
	}()
	
	private lazy var photoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
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
		label.font = UIFont.systemFont(ofSize: 24)
		label.contentMode = .scaleAspectFill
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var ageLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = UIColor.systemBackground
		label.font = UIFont.systemFont(ofSize: 24)
		label.contentMode = .scaleAspectFill
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var descriptionTextView: UITextView = {
		let textView = UITextView(frame: .zero, textContainer: nil)
		textView.backgroundColor = UIColor.systemBackground
		textView.font = UIFont.systemFont(ofSize: 18)
		textView.textAlignment = .left
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
		configureLayoutView()
		configureLayoutScrollView()
	}
	
	func setPhoto(named: String) {
		self.photoImageView.image = UIImage(named: named)
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
	
	func configureLayoutView() {
		let scrollArea = scrollView.contentLayoutGuide
		self.scrollView.addSubview(photoImageView)
		self.scrollView.addSubview(fullNameLabel)
		self.scrollView.addSubview(ageLabel)
		self.scrollView.addSubview(descriptionTextView)
		
		NSLayoutConstraint.activate([
			self.photoImageView.centerXAnchor.constraint(equalTo: scrollArea.centerXAnchor),
			self.photoImageView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
													 constant: (self.bounds.height / 8)),
			self.photoImageView.heightAnchor.constraint(equalToConstant: self.bounds.width / 100 * 50),
			self.photoImageView.widthAnchor.constraint(equalToConstant: self.bounds.width / 100 * 50)
		])

		NSLayoutConstraint.activate([
			self.fullNameLabel.centerXAnchor.constraint(equalTo: scrollArea.centerXAnchor),
			self.fullNameLabel.topAnchor.constraint(equalTo: self.photoImageView.bottomAnchor,
													constant: ProfileTabLayout.topAnchorLabel)
		])
		
		NSLayoutConstraint.activate([
			self.ageLabel.centerXAnchor.constraint(equalTo: scrollArea.centerXAnchor),
			self.ageLabel.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor,
											   constant: ProfileTabLayout.topAnchorLabel)
		])
		
		NSLayoutConstraint.activate([
			self.descriptionTextView.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor,
														  constant: ProfileTabLayout.topAnchorText),
			self.descriptionTextView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
															  constant: ProfileTabLayout.leadingAnchorText),
			self.descriptionTextView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
															   constant: ProfileTabLayout.trailingAnchorText),
			self.descriptionTextView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
															 constant: ProfileTabLayout.scrollViewBottomAnchor)
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
