//
//  ListCarsViewCell.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import UIKit

final class ListCarsViewCell: UITableViewCell {
	static let identifier = "ListCarsTableViewCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		self.configureUI()
		self.configureImageView()
		self.configureText()
		self.configureDetailText()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.imageView?.frame = .init(x: ListCarsLayout.cellImageViewX,
									  y: self.bounds.height / ListCarsLayout.cellContentY,
									  width: ListCarsLayout.cellImageViewSize,
									  height: ListCarsLayout.cellImageViewSize)
		
		self.textLabel?.frame = .init(x: ListCarsLayout.cellTitleTextX,
									  y: self.bounds.height / ListCarsLayout.cellContentY,
									  width: self.bounds.width / ListCarsLayout.cellTitleTextWidth,
									  height: ListCarsLayout.cellTitleTextHeight)
		
		self.detailTextLabel?.frame = .init(x: self.bounds.width - ListCarsLayout.cellDetailTextX,
											y: self.bounds.height / ListCarsLayout.cellContentY,
											width: ListCarsLayout.cellDetailTextWidth,
											height: ListCarsLayout.cellDetailTextHeight)
	}
}

extension ListCarsViewCell {
	func setData(car data: CarModel) {
		self.textLabel?.text = data.name
	}
	
	func setImageColor(_ color: UIColor) {
		self.imageView?.backgroundColor = color
	}
}

private extension ListCarsViewCell {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
		
	func configureImageView() {
		self.imageView?.image = UIImage()
		self.imageView?.contentMode = .scaleAspectFit
		self.imageView?.layer.cornerRadius = ListCarsLayout.cellImageViewCornerRadius
		self.imageView?.layer.masksToBounds = true
	}
	
	func configureDetailText() {
		self.detailTextLabel?.text = "Select"
		self.detailTextLabel?.textColor = .label
		self.detailTextLabel?.numberOfLines = 2
		self.detailTextLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
	}
	
	func configureText() {
		self.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
	}
}
