//
//  DetailCarViewCell.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

final class DetailCarViewCell: UITableViewCell {
	static let identifier = "DetailCarViewCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		self.configureUI()
		self.configureImageView()
		self.configureText()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		if selected == true {
			self.imageView?.image = UIImage(named: "radio_button_fill")
		}
		else {
			self.imageView?.image = UIImage(named: "radio_button")
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.imageView?.frame = .init(x: self.bounds.width / DetailCarLayout.cellImageViewX,
									  y: self.bounds.height / DetailCarLayout.cellContentY,
									  width: DetailCarLayout.cellImageViewSize,
									  height: DetailCarLayout.cellImageViewSize)
		
		self.textLabel?.frame = .init(x: DetailCarLayout.cellTitleTextX,
									  y: self.bounds.height / DetailCarLayout.cellContentY,
									  width: self.bounds.width / DetailCarLayout.cellTitleTextWidth,
									  height: DetailCarLayout.cellTitleTextHeight)
	}
}

extension DetailCarViewCell {
	func setData(with data: CarBody) {
		self.textLabel?.text = data.rawValue.name
	}
}

private extension DetailCarViewCell {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
		
	func configureImageView() {
		self.imageView?.contentMode = .scaleAspectFit
		self.imageView?.layer.masksToBounds = true
	}
	
	func configureText() {
		self.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
	}
}
