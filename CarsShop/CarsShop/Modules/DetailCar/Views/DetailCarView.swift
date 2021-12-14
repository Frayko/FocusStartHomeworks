//
//  DetailCarView.swift
//  CarsShop
//
//  Created by Александр Фомин on 12.12.2021.
//

import UIKit

protocol IDetailCarView: UIView
{
	func setTableViewDelegate(delegate: IDetailCarDataHandler)
	func setTableViewDataSource(dataSource: IDetailCarDataHandler)
	func setOnTouchedButtonHandler(_ handler: @escaping (() -> Void))
	func setCarImageName(_ named: String)
	func setPrice(_ price: Double)
	func showActivityIndicator()
	func hideActivityIndicator()
	func didLoad()
	func reloadView()
}

final class DetailCarView: UIView
{
	private var onTouchedButtonHandler: (() -> Void)?
	private var countActivityIndicators: Int
	
	override init(frame: CGRect) {
		self.countActivityIndicators = 0
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private lazy var carImageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var priceTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Цена"
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 24, weight: .medium)
		return label
	}()
	
	private lazy var priceLabel: UILabel = {
		let label = UILabel()
		label.text = "0.0$"
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .left
		label.font = .systemFont(ofSize: 16, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var tableTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Выберите тип кузова"
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 24, weight: .medium)
		return label
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.rowHeight = DetailCarLayout.tableRowHeight
		tableView.tableHeaderView = UIView()
		tableView.register(DetailCarViewCell.self,
						   forCellReuseIdentifier: DetailCarViewCell.identifier)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	private lazy var calculatePriceButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Рассчитать цену", for: .normal)
		button.addTarget(self, action: #selector(self.onTouched), for: .touchDown)
		button.tintColor = .systemBackground
		button.backgroundColor = DetailCarColors.green
		button.layer.cornerRadius = DetailCarLayout.calculateButtonCornerRadius
		button.layer.masksToBounds = true
		button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentMode = .scaleAspectFill
		return button
	}()
	
	private lazy var activityIndicatorView: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView()
		activityIndicator.color = DetailCarColors.green
		activityIndicator.hidesWhenStopped = true
		activityIndicator.style = .large
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		return activityIndicator
	}()
	
	private lazy var activityIndicatorBackgroundView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.image = UIImage()
		imageView.isHidden = true
		imageView.backgroundColor = DetailCarColors.activityIndicatorBackgroundColor
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = DetailCarLayout.activityIndicatorBackgroundViewCornerRadius
		imageView.layer.opacity = DetailCarLayout.activityIndicatorBackgroundViewOpacity
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
}

extension DetailCarView: IDetailCarView
{
	func setTableViewDelegate(delegate: IDetailCarDataHandler) {
		self.tableView.delegate = delegate
	}
	
	func setTableViewDataSource(dataSource: IDetailCarDataHandler) {
		self.tableView.dataSource = dataSource
	}
	
	func didLoad() {
		self.configureUI()
		self.configureView()
		self.configureActivityIndicator()
	}
	
	func setCarImageName(_ named: String) {
		self.carImageView.image = UIImage(named: named)
	}
	
	func setPrice(_ price: Double) {
		self.priceLabel.text = "\(price)$"
	}
	
	func showActivityIndicator() {
		self.activityIndicatorBackgroundView.isHidden = false
		self.activityIndicatorView.startAnimating()
		self.countActivityIndicators += 1
	}
	
	func hideActivityIndicator() {
		self.countActivityIndicators -= 1
		if self.countActivityIndicators == 0 {
			self.activityIndicatorBackgroundView.isHidden = true
			self.activityIndicatorView.stopAnimating()
		}
	}
	
	func setOnTouchedButtonHandler(_ handler: @escaping (() -> Void)) {
		self.onTouchedButtonHandler = handler
	}
	
	func reloadView() {
		self.tableView.reloadData()
	}
}

private extension DetailCarView
{
	@objc
	func onTouched() {
		self.onTouchedButtonHandler?()
	}
	
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureView() {
		self.addSubview(self.carImageView)
		self.addSubview(self.priceTitleLabel)
		self.addSubview(self.priceLabel)
		self.addSubview(self.tableTitleLabel)
		self.addSubview(self.tableView)
		self.addSubview(self.calculatePriceButton)
		
		let safeArea = self.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			self.carImageView.topAnchor.constraint(equalTo: safeArea.topAnchor,
												   constant: DetailCarLayout.carImageViewTopAnchor),
			self.carImageView.heightAnchor.constraint(equalToConstant: DetailCarLayout.carImageViewHeight),
			self.carImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
													   constant: DetailCarLayout.leadingAnchor),
			self.carImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
														constant: DetailCarLayout.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			self.priceTitleLabel.topAnchor.constraint(equalTo: self.carImageView.bottomAnchor,
													  constant: DetailCarLayout.priceTitleTopAnchor),
			self.priceTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
														  constant: DetailCarLayout.leadingAnchor),
			self.priceTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
														   constant: DetailCarLayout.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			self.priceLabel.topAnchor.constraint(equalTo: self.priceTitleLabel.bottomAnchor,
												 constant: DetailCarLayout.priceTopAnchor),
			self.priceLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
													 constant: DetailCarLayout.leadingAnchor),
			self.priceLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
													  constant: DetailCarLayout.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			self.tableTitleLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor,
													  constant: DetailCarLayout.tableTitleTopAnchor),
			self.tableTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
														  constant: DetailCarLayout.leadingAnchor),
			self.tableTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
														   constant: DetailCarLayout.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			self.tableView.topAnchor.constraint(equalTo: self.tableTitleLabel.bottomAnchor,
												constant: DetailCarLayout.tableViewTopAnchor),
			self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			self.calculatePriceButton.topAnchor.constraint(equalTo: self.tableView.bottomAnchor,
														   constant: DetailCarLayout.calculateButtonTopAnchor),
			self.calculatePriceButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
															   constant: DetailCarLayout.leadingAnchor),
			self.calculatePriceButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
																constant: DetailCarLayout.trailingAnchor),
			self.calculatePriceButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
															  constant: DetailCarLayout.calculateButtonBottomAnchor),
			self.calculatePriceButton.heightAnchor.constraint(equalToConstant: DetailCarLayout.calculateButtonHeight)
		])
	}
	
	func configureActivityIndicator() {
		self.addSubview(self.activityIndicatorBackgroundView)
		self.addSubview(self.activityIndicatorView)
		
		NSLayoutConstraint.activate([
			self.activityIndicatorBackgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.activityIndicatorBackgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			self.activityIndicatorBackgroundView.widthAnchor.constraint(equalToConstant: DetailCarLayout.activityIndicatorBackgroundViewSize),
			self.activityIndicatorBackgroundView.heightAnchor.constraint(equalToConstant: DetailCarLayout.activityIndicatorBackgroundViewSize)
		])
		
		NSLayoutConstraint.activate([
			self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
}
