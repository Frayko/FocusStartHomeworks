//
//  LoadImagesViewCell.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

final class LoadImagesViewCell: UITableViewCell
{
	static let identifier = "LoadImagesTableViewCell"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		self.configureUI()
		self.configureView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.loadedImageView.image = nil
	}
	
	private lazy var loadedImageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: LoadImagesLayout.cellImageViewHeight).isActive = true
		imageView.backgroundColor = .systemGray4
		imageView.layer.cornerRadius = LoadImagesLayout.cellImageViewCornerRadius
		imageView.clipsToBounds = true
		return imageView
	}()
}

extension LoadImagesViewCell
{
	func setImage(_ image: UIImage) {
		self.loadedImageView.image = image
	}
}

private extension LoadImagesViewCell
{
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureView() {
		self.contentView.addSubview(self.loadedImageView)
		
		NSLayoutConstraint.activate([
			self.loadedImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			self.loadedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}
}
