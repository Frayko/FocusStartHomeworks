//
//  LoadImagesView.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

protocol ILoadImagesView: UIView
{
	func setTableViewDelegate(delegate: ILoadImagesDataHandler)
	func setTableViewDataSource(dataSource: ILoadImagesDataHandler)
	func setSearchBarDelegate(delegate: ILoadImagesDataHandler)
	func setProgressData(data: LoadImagesStatsModel)
	func didLoad()
	func reloadView()
}

final class LoadImagesView: UIView
{
	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar(frame: .zero)
		searchBar.autocapitalizationType = .none
		searchBar.autocorrectionType = .no
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.placeholder = "Введите ссылку"
		return searchBar
	}()
	
	private lazy var progressView: UIProgressView = {
		let progressView = UIProgressView()
		progressView.progress = 0
		progressView.progressViewStyle = .default
		progressView.layer.cornerRadius = LoadImagesLayout.progressViewCornerRadius
		progressView.layer.masksToBounds = true
		progressView.translatesAutoresizingMaskIntoConstraints = false
		return progressView
	}()
	
	private lazy var progressLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12)
		label.textColor = .label
		label.textAlignment = .center
		return label
	}()
	
	private lazy var progressStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [self.progressView, self.progressLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = LoadImagesLayout.stackViewSpacing
		stackView.axis = .vertical
		stackView.isHidden = true
		return stackView
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.rowHeight = LoadImagesLayout.tableRowHeight
		tableView.tableHeaderView = UIView()
		tableView.separatorStyle = .none
		tableView.register(LoadImagesViewCell.self,
						   forCellReuseIdentifier: LoadImagesViewCell.identifier)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
}

extension LoadImagesView: ILoadImagesView
{
	func setProgressData(data: LoadImagesStatsModel) {
		if data.totalBytesExpectedToWrite == 0 {
			self.progressView.progress = 0
			self.progressStackView.isHidden = true
		}
		else {
			if self.progressStackView.isHidden == true {
				self.progressStackView.isHidden = false
			}
			self.progressView.progress = data.totalBytesWritten / data.totalBytesExpectedToWrite
		}
		
		let formattedString = String(format: "%.2f из %.2f МБ, количество загрузок: %d",
									 data.totalBytesWritten,
									 data.totalBytesExpectedToWrite,
									 data.countDownloads)
		self.progressLabel.text = formattedString
	}
	
	func setSearchBarDelegate(delegate: ILoadImagesDataHandler) {
		self.searchBar.delegate = delegate
	}
	
	func setTableViewDelegate(delegate: ILoadImagesDataHandler) {
		self.tableView.delegate = delegate
	}
	
	func setTableViewDataSource(dataSource: ILoadImagesDataHandler) {
		self.tableView.dataSource = dataSource
	}
	
	func didLoad() {
		self.configureUI()
		self.configureView()
	}
	
	func reloadView() {
		self.tableView.reloadData()
	}
}

private extension LoadImagesView
{
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureView() {
		let vStack = UIStackView(arrangedSubviews: [self.searchBar,
													self.progressStackView,
													self.tableView])
		vStack.axis = .vertical
		vStack.spacing = LoadImagesLayout.stackViewSpacing
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		self.addSubview(vStack)
		
		let safeArea = self.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			vStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
			vStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			vStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			vStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}
}
