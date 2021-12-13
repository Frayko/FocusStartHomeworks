//
//  ListCarsLayout.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import UIKit

enum ListCarsLayout {
	static let scrollViewTopAnchor: CGFloat = 40.0
	static let scrollViewLeadingAnchor: CGFloat = 18.0
	static let scrollViewTrailingAnchor: CGFloat = -scrollViewLeadingAnchor
	static let scrollViewBottomAnchor: CGFloat = -18.0
	
	static let tableRowHeight: CGFloat = 43
	static let tableViewTopAnchor: CGFloat = 12
	
	static let cellContentY: CGFloat = 5
	
	static let cellImageViewSize: CGFloat = 16
	static let cellImageViewCornerRadius: CGFloat = 8
	static let cellImageViewX: CGFloat = 16
	
	static let cellTitleTextX: CGFloat = 48
	static let cellTitleTextWidth: CGFloat = 1.38
	static let cellTitleTextHeight: CGFloat = 17
	
	static let cellDetailTextX: CGFloat = 1.17
	static let cellDetailTextWidth: CGFloat = 270
	static let cellDetailTextHeight: CGFloat = 17
}
