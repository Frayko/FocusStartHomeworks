//
//  FullImageVC.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

protocol IFullImageVC: UIViewController {
	func setImage(named: String)
}

final class FullImageVC: UIViewController {
	private let viewModel: IFullImageViewModel
	private let rootView: IFullImageView = FullImageView(frame: UIScreen.main.bounds)
	
	struct Dependecies {
		let viewModel: IFullImageViewModel
	}
	
	init(dependecies: Dependecies) {
		self.viewModel = dependecies.viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = self.rootView
		self.viewModel.loadView()
		setHandlers()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewModel.getImageName().setNotify { [weak self] imageName in
			self?.setImage(named: imageName)
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.rootView.didLoad()
	}
	
	override func viewDidLayoutSubviews() {
		resizeImage()
	}
}

private extension FullImageVC {
	func onTouched() {
		self.dismiss(animated: true)
	}
	
	func setHandlers() {
		self.rootView.setOnTouchedHandler { [weak self] in
			self?.onTouched()
		}
	}
	
	func resizeImage() {
		let image = self.rootView.image
		
		let height = image.size.height
		let width: CGFloat
		if image.size.width == 0 {
			width = 1
		}
		else {
			width = image.size.width
		}
		let ratio = height / width
		
		let widthConstant: CGFloat
		if self.rootView.bounds.width < self.rootView.bounds.height {
			widthConstant = self.rootView.bounds.width - AnimePageLayout.scrollViewLeadingAnchor * 2
		}
		else {
			widthConstant = self.rootView.bounds.width - AnimePageLayout.scrollViewLeadingAnchor * 10
		}
		let heightConstant = ratio * widthConstant
		
		self.rootView.resizeImage(widthConstant: widthConstant, heightConstant: heightConstant)
	}
}

extension FullImageVC: IFullImageVC {
	func setImage(named: String) {
		self.rootView.setImage(named: named)
	}
}
