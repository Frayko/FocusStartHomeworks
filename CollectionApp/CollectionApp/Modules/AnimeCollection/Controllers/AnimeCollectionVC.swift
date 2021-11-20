//
//  AnimeCollectionVC.swift
//  CollectionApp
//
//  Created by Александр Фомин on 20.11.2021.
//

import UIKit

final class AnimeControllerVC: UIViewController {
	enum Section: CaseIterable {
		case main
	}
	
	private let animesController = AnimesController()
	private var dataSource: UICollectionViewDiffableDataSource<Section, Anime>!
	var nameFilter: String?
	
	private lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar(frame: .zero)
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.placeholder = "Поиск"
		searchBar.delegate = self
		return searchBar
	}()
	
	private lazy var animesCollectionView: UICollectionView = {
		let layout = createLayout()
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .systemBackground
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		return collectionView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Каталог аниме"
		configureView()
		configureDataSource()
		performQuery(with: nil)
	}
}

extension AnimeControllerVC {
	func configureDataSource() {
		
		let cellRegistration = UICollectionView.CellRegistration
		<AnimeCell, Anime> { (cell, indexPath, anime) in
			cell.setImage(named: anime.imageName)
			cell.setTitle(anime.name)
		}
		
		dataSource = UICollectionViewDiffableDataSource<Section, Anime>(collectionView: animesCollectionView) {
			(collectionView: UICollectionView, indexPath: IndexPath, identifier: Anime) -> UICollectionViewCell? in
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
		}
	}
	
	func performQuery(with filter: String?) {
		let animes = animesController.filteredAnimes(with: filter).sorted { $0.name < $1.name }

		var snapshot = NSDiffableDataSourceSnapshot<Section, Anime>()
		snapshot.appendSections([.main])
		snapshot.appendItems(animes)
		dataSource.apply(snapshot, animatingDifferences: true)
	}
}

extension AnimeControllerVC {
	func createLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
			layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
			let contentSize = layoutEnvironment.container.effectiveContentSize

			let columns = Int(round(contentSize.width / AnimeCollectionLayout.cellHeight))
			let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												  heightDimension: .fractionalHeight(1.0))
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
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

	func configureView() {
		self.view.backgroundColor = .systemBackground
		
		let vStack = UIStackView(arrangedSubviews: [self.searchBar, self.animesCollectionView])
		vStack.axis = .vertical
		vStack.spacing = AnimeCollectionLayout.stackViewSpacing
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		self.view.addSubview(vStack)
		
		let safeArea = self.view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			vStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
			vStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			vStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			vStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}
}

extension AnimeControllerVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		performQuery(with: searchText)
	}
}
