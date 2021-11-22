//
//  FullImageVC.swift
//  CollectionApp
//
//  Created by Александр Фомин on 22.11.2021.
//

import UIKit

protocol IFullImageVC: UIViewController {
	func setImage(_ image: UIImage)
}

final class FullImageVC: UIViewController {
	private let rootView: IFullImageView = FullImageView()
	
	override func loadView() {
		self.view = self.rootView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.rootView.didLoad()
		configureCloseButton()
	}
	
	override func viewDidLayoutSubviews() {
		resizeImage()
	}
}

private extension FullImageVC {
	func resizeImage() {
		let image = self.rootView.image
		
		let height = image.size.height
		let width = image.size.width
		let ratio = height / width
		
		let widthConstant = self.rootView.bounds.width - AnimePageLayout.scrollViewLeadingAnchor * 2
		let heightConstant = ratio * widthConstant
		
		self.rootView.resizeImage(widthConstant: widthConstant, heightConstant: heightConstant)
	}
	
	func configureCloseButton() {
		self.rootView.addCloseButtonTarget(self, action: #selector(closeFullImage))
	}
	
	@objc func closeFullImage() {
		self.dismiss(animated: true)
	}
}

extension FullImageVC: IFullImageVC {
	func setImage(_ image: UIImage) {
		self.rootView.setImage(image)
	}
}
