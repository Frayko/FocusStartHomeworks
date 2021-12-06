//
//  FullImageView.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

protocol IFullImageView: UIView {
	func getImageSize() -> CGSize
	func didLoad()
	func setOnTouchedHandler(_ handler: @escaping (() -> Void))
	func setImage(named: String)
	func resizeImage(widthConstant: CGFloat, heightConstant: CGFloat)
}

final class FullImageView: UIView {
	private var onTouchedHandler: (() -> Void)?
	private var imageViewHeightConstraint = NSLayoutConstraint()
	private var imageViewWidthConstraint = NSLayoutConstraint()
	
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
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView(frame: self.bounds)
		imageView.layer.cornerRadius = FullImageLayout.imageViewCornerRadius
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.center = self.center
		return imageView
	}()
	
	private lazy var closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(.init(systemName: "xmark"), for: .normal)
		button.addTarget(self, action: #selector(self.touchedDown), for: .touchDown)
		button.tintColor = .label
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentMode = .scaleAspectFit
		return button
	}()
}

extension FullImageView: IFullImageView {
	func getImageSize() -> CGSize {
		self.imageView.image?.size ?? CGSize(width: 1, height: 0)
	}
	
	func setOnTouchedHandler(_ handler: @escaping (() -> Void)) {
		self.onTouchedHandler = handler
	}
	
	func didLoad() {
		self.configureUI()
		self.configureView()
		self.configureScrollView()
		self.configureCloseButtonView()
	}
	
	func setImage(named: String) {
		self.imageView.image = UIImage(named: named)
	}
	
	func resizeImage(widthConstant: CGFloat, heightConstant: CGFloat) {
		NSLayoutConstraint.deactivate([
			self.imageViewWidthConstraint,
			self.imageViewHeightConstraint
		])
		
		self.imageViewWidthConstraint = self.imageView.widthAnchor.constraint(equalToConstant: widthConstant)
		self.imageViewHeightConstraint = self.imageView.heightAnchor.constraint(equalToConstant: heightConstant)
		
		NSLayoutConstraint.activate([
			self.imageViewWidthConstraint,
			self.imageViewHeightConstraint
		])
	}
}

private extension FullImageView {
	@objc private func touchedDown() {
		self.onTouchedHandler?()
	}
	
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureView() {
		let scrollArea = self.scrollView.contentLayoutGuide
		self.scrollView.addSubview(self.imageView)

		NSLayoutConstraint.activate([
			self.imageView.centerXAnchor.constraint(equalTo: scrollArea.centerXAnchor),
			self.imageView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
												constant: FullImageLayout.scrollViewTopAnchor),
			self.imageView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
												   constant: FullImageLayout.scrollViewBottomAnchor)
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
	
	func configureCloseButtonView() {
		self.addSubview(self.closeButton)
		
		NSLayoutConstraint.activate([
			self.closeButton.topAnchor.constraint(equalTo: self.topAnchor,
												  constant: FullImageLayout.closeButtonTopAnchor),
			self.closeButton.rightAnchor.constraint(equalTo: self.rightAnchor,
													constant: FullImageLayout.closeButtonRightAnchor)
		])
	}
}
