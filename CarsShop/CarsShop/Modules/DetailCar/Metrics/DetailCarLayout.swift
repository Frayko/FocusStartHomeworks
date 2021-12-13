//
//  DetailCarLayout.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

enum DetailCarLayout {
	static let leadingAnchor: CGFloat = 16
	static let trailingAnchor: CGFloat = -leadingAnchor
	
	static let carImageViewTopAnchor: CGFloat = 13
	static let carImageViewWidth: CGFloat = 1.1
	static let carImageViewHeight: CGFloat = 196
	
	static let priceTitleTopAnchor: CGFloat = 23
	static let priceTopAnchor: CGFloat = 8
	static let tableTitleTopAnchor: CGFloat = 23
	
	static let tableViewTopAnchor: CGFloat = 1
	static let tableRowHeight: CGFloat = 51
	
	static let cellContentY: CGFloat = 3
	
	static let cellImageViewSize: CGFloat = 16
	static let cellImageViewX: CGFloat = cellImageViewSize + 18
	
	static let cellTitleTextX: CGFloat = 15
	static let cellTitleTextWidth: CGFloat = 1.38
	static let cellTitleTextHeight: CGFloat = 17
	
	static let calculateButtonTopAnchor: CGFloat = 12
	static let calculateButtonBottomAnchor: CGFloat = -12
	static let calculateButtonHeight: CGFloat = 51
	static let calculateButtonCornerRadius: CGFloat = 25
	
	static let activityIndicatorBackgroundViewOpacity: Float = 0.95
	static let activityIndicatorBackgroundViewSize: CGFloat = 64
	static let activityIndicatorBackgroundViewCornerRadius: CGFloat = 16
}
