//
//  FullImageView.swift
//  CollectionApp
//
//  Created by Александр Фомин on 22.11.2021.
//

import UIKit

protocol IFullImageView: UIView {
	var image: UIImage { get }
	func didLoad()
	func setImage(_ image: UIImage)
	func addCloseButtonTarget(_ target: UIViewController, action: Selector)
	func resizeImage(widthConstant: CGFloat, heightConstant: CGFloat)
}

final class FullImageView: UIView {
	private var imageViewHeightConstraint = NSLayoutConstraint()
	private var imageViewWidthConstraint = NSLayoutConstraint()
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.layer.masksToBounds = true
		return scrollView
	}()
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView(frame: self.bounds)
		imageView.layer.cornerRadius = AnimePageLayout.imageViewCornerRadius
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.center = self.center
		return imageView
	}()
	
	private lazy var closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(.init(systemName: "xmark"), for: .normal)
		button.tintColor = .label
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentMode = .scaleAspectFit
		return button
	}()
}

extension FullImageView: IFullImageView {
	var image: UIImage {
		self.imageView.image ?? UIImage()
	}
	
	func addCloseButtonTarget(_ target: UIViewController, action: Selector) {
		closeButton.addTarget(target, action: action, for: .touchUpInside)
	}
	
	func didLoad() {
		configureUI()
		configureView()
		configureScrollView()
		configureCloseButtonView()
	}
	
	func setImage(_ image: UIImage) {
		self.imageView.image = image
	}
	
	func resizeImage(widthConstant: CGFloat, heightConstant: CGFloat) {
		NSLayoutConstraint.deactivate([
			self.imageViewWidthConstraint,
			self.imageViewHeightConstraint
		])
		
		imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: widthConstant)
		imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: heightConstant)
		
		NSLayoutConstraint.activate([
			self.imageViewWidthConstraint,
			self.imageViewHeightConstraint
		])
	}
}

private extension FullImageView {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureView() {
		let scrollArea = self.scrollView.contentLayoutGuide
		self.scrollView.addSubview(self.imageView)

		NSLayoutConstraint.activate([
			self.imageView.centerXAnchor.constraint(equalTo: scrollArea.centerXAnchor),
			self.imageView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
												constant: AnimePageLayout.scrollViewTopAnchor),
			self.imageView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
												   constant: AnimePageLayout.scrollViewBottomAnchor)
		])
	}
	
	func configureScrollView() {
		let safeArea = self.safeAreaLayoutGuide
		self.addSubview(self.scrollView)

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
	
	func configureCloseButtonView() {
		self.addSubview(self.closeButton)
		
		NSLayoutConstraint.activate([
			self.closeButton.topAnchor.constraint(equalTo: self.topAnchor,
												  constant: AnimePageLayout.closeButtonTopAnchor),
			self.closeButton.rightAnchor.constraint(equalTo: self.rightAnchor,
													constant: AnimePageLayout.closeButtonRightAnchor)
		])
	}
}
