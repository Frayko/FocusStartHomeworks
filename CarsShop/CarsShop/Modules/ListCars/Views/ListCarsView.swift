//
//  ListCarsView.swift
//  CarsShop
//
//  Created by Александр Фомин on 09.12.2021.
//

import UIKit

protocol IListCarsView: UIView
{
	func setTableViewDelegate(delegate: IListCarsDataHandler)
	func setTableViewDataSource(dataSource: IListCarsDataHandler)
	func didLoad()
	func reloadView()
}

final class ListCarsView: UIView
{
	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Марку машины"
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 24, weight: .medium)
		return label
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.rowHeight = ListCarsLayout.tableRowHeight
		tableView.tableHeaderView = UIView()
		tableView.register(ListCarsViewCell.self,
						   forCellReuseIdentifier: ListCarsViewCell.identifier)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
}

extension ListCarsView: IListCarsView
{
	func setTableViewDelegate(delegate: IListCarsDataHandler) {
		self.tableView.delegate = delegate
	}
	
	func setTableViewDataSource(dataSource: IListCarsDataHandler) {
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

private extension ListCarsView
{
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureView() {
		self.addSubview(self.tableView)
		self.addSubview(self.titleLabel)
		
		let safeArea = self.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
												 constant: ListCarsLayout.scrollViewTopAnchor),
			self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
													 constant: ListCarsLayout.scrollViewLeadingAnchor),
			self.titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			self.tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
												constant: ListCarsLayout.tableViewTopAnchor),
			self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}
}
