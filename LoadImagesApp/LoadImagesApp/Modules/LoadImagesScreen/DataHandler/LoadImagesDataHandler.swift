//
//  LoadImagesDataHandler.swift
//  LoadImagesApp
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

protocol ILoadImagesDataHandler: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
	func setImages(_ images: [UIImage])
	func setOnRequestTextHandler(_ handler: @escaping ((_ url: String) -> Void))
}

final class LoadImagesDataHandler: NSObject
{
	private var images: [UIImage]?
	private var onRequestTextHandler: ((_ url: String) -> Void)?
}

extension LoadImagesDataHandler: ILoadImagesDataHandler
{
	func setImages(_ images: [UIImage]) {
		self.images = images
	}
	
	func setOnRequestTextHandler(_ handler: @escaping ((_ url: String) -> Void)) {
		self.onRequestTextHandler = handler
	}
}

extension LoadImagesDataHandler: UITableViewDelegate
{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension LoadImagesDataHandler: UITableViewDataSource
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.images?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: LoadImagesViewCell.identifier, for: indexPath) as! LoadImagesViewCell
		
		guard
			let image = self.images?[indexPath.item]
		else {
			return cell
		}
		
		cell.selectionStyle = .none
		cell.setImage(image)
		return cell
	}
}

extension LoadImagesDataHandler: UISearchBarDelegate
{
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text else { return }
		self.onRequestTextHandler?(text)
	}
	
	func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
		true
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(true, animated: true)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		searchBar.setShowsCancelButton(false, animated: true)
	}
}
