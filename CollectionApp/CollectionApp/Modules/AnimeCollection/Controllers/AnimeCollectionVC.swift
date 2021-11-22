//
//  AnimeCollectionVC.swift
//  CollectionApp
//
//  Created by Александр Фомин on 20.11.2021.
//

import UIKit

final class AnimeCollectionVC: UIViewController {
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
		navigationItem.backButtonDisplayMode = .minimal
		animesCollectionView.delegate = self
		self.view.addSubview(animesCollectionView)
		animesCollectionView.frame = self.view.bounds
		configureView()
		configureDataSource()
		performQuery(with: nil)
	}
}

extension AnimeCollectionVC: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		animesCollectionView.deselectItem(at: indexPath, animated: true)
		guard let anime = dataSource.itemIdentifier(for: indexPath) else {
			return
		}
		
		let animePageVC: IAnimePageVC = AnimePageVC()
		animePageVC.setImage(named: anime.imageName)
		animePageVC.setTitle(anime.title)
		animePageVC.setTags(anime.tags)
		animePageVC.setDescription(anime.description)
		self.navigationController?.pushViewController(animePageVC, animated: true)
	}
}

private extension AnimeCollectionVC {
	func configureDataSource() {
		let cellRegistration = UICollectionView.CellRegistration
		<AnimeCell, Anime> { (cell, indexPath, anime) in
			cell.setImage(named: anime.imageName)
			cell.setTitle(anime.title)
		}
		
		dataSource = UICollectionViewDiffableDataSource<Section, Anime>(collectionView: animesCollectionView) {
			(collectionView: UICollectionView, indexPath: IndexPath, identifier: Anime) -> UICollectionViewCell? in
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
		}
	}
	
	func performQuery(with filter: String?) {
		let animes = animesController.filteredAnimes(with: filter).sorted { $0.title < $1.title }

		var snapshot = NSDiffableDataSourceSnapshot<Section, Anime>()
		snapshot.appendSections([.main])
		snapshot.appendItems(animes)
		dataSource.apply(snapshot, animatingDifferences: true)
	}
}

private extension AnimeCollectionVC {
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

extension AnimeCollectionVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		performQuery(with: searchText)
	}
}
