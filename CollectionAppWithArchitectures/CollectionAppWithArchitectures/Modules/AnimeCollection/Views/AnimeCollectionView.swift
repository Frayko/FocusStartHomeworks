//
//  AnimeCollectionView.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

import UIKit

protocol IAnimeCollectionView: UIView {
	func didLoad()
	func loadView(controller: IAnimeCollectionVC)
	func getSearchBar() -> UISearchBar
	func getAnimesCollectionView() -> UICollectionView
}

final class AnimeCollectionView: UIView {
	private weak var controller: IAnimeCollectionVC?
	
	private lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar(frame: .zero)
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.placeholder = "Поиск"
		return searchBar
	}()
	
	private lazy var animesCollectionView: UICollectionView = {
		let layout = createAnimeCollectionLayout()
		let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .systemBackground
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		return collectionView
	}()
}

extension AnimeCollectionView: IAnimeCollectionView {
	func loadView(controller: IAnimeCollectionVC) {
		self.controller = controller
	}
	
	func getSearchBar() -> UISearchBar {
		self.searchBar
	}
	
	func getAnimesCollectionView() -> UICollectionView {
		self.animesCollectionView
	}
	
	func didLoad() {
		configUI()
		configView()
	}
}

private extension AnimeCollectionView {
	func configUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configView() {
		let vStack = UIStackView(arrangedSubviews: [self.searchBar, self.animesCollectionView])
		vStack.axis = .vertical
		vStack.spacing = AnimeCollectionLayout.stackViewSpacing
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
	
	func createAnimeCollectionLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
			layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
			let contentSize = layoutEnvironment.container.effectiveContentSize

			let columns = Int(round(contentSize.width / AnimeCollectionLayout.cellHeight))
			let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(AnimeCollectionLayout.itemWidthSize),
												  heightDimension: .fractionalHeight(AnimeCollectionLayout.itemHeightSize))
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(AnimeCollectionLayout.cellWidth),
												   heightDimension: .absolute(AnimeCollectionLayout.cellHeight))
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
			group.interItemSpacing = .fixed(AnimeCollectionLayout.collectionViewSpacing)

			let section = NSCollectionLayoutSection(group: group)
			section.interGroupSpacing = AnimeCollectionLayout.collectionViewSpacing
			section.contentInsets = NSDirectionalEdgeInsets(top: AnimeCollectionLayout.sectionTopInset,
															leading: AnimeCollectionLayout.sectionLeadingInset,
															bottom: AnimeCollectionLayout.sectionBottomInset,
															trailing: AnimeCollectionLayout.sectionTrailingInset)

			return section
		}
		return layout
	}
}
