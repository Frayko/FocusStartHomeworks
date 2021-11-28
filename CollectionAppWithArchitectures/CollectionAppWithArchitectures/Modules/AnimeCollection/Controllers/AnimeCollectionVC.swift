//
//  AnimeCollectionVC.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 27.11.2021.
//

import UIKit

protocol IAnimeCollectionVC: UIViewController {
	
}

final class AnimeCollectionVC: UIViewController {
	enum Section: CaseIterable {
		case main
	}
	
	private let appRouter: AppRouter
	private let animeCollectionView: IAnimeCollectionView
	private let animesModel = AnimesModel()
	private var dataSource: UICollectionViewDiffableDataSource<Section, AnimeModel>!
	
	init() {
		appRouter = AppRouter()
		animeCollectionView = AnimeCollectionView()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Каталог аниме"
		navigationItem.backButtonDisplayMode = .minimal
		self.view = animeCollectionView
		animeCollectionView.didLoad()
		
		animeCollectionView.getSearchBar().delegate = self
		animeCollectionView.getAnimesCollectionView().delegate = self
			
		configureDataSource()
		performQuery(with: nil)
	}
	
	override func loadView() {
		super.loadView()
		self.animeCollectionView.loadView(controller: self)
	}
}

extension AnimeCollectionVC: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.animeCollectionView.getAnimesCollectionView().deselectItem(at: indexPath, animated: true)
		guard let anime = dataSource.itemIdentifier(for: indexPath) else {
			return
		}
		
		let animePageVC = AnimePageAssembly.build(animeIdentifier: anime.identifier)
		self.appRouter.setController(controller: self)
		self.appRouter.setTargerController(controller: animePageVC)
		self.appRouter.next()
	}
}

private extension AnimeCollectionVC {
	func configureDataSource() {
		let cellRegistration = UICollectionView.CellRegistration
		<AnimeCell, AnimeModel> { (cell, indexPath, anime) in
			cell.setImage(named: anime.imageName)
			cell.setTitle(anime.title)
		}
		
		dataSource = UICollectionViewDiffableDataSource<Section, AnimeModel>(collectionView: self.animeCollectionView.getAnimesCollectionView()) {
			(collectionView: UICollectionView, indexPath: IndexPath, identifier: AnimeModel) -> UICollectionViewCell? in
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
		}
	}
	
	func performQuery(with filter: String?) {
		let animes = animesModel.filteredAnimes(with: filter).sorted { $0.title < $1.title }

		var snapshot = NSDiffableDataSourceSnapshot<Section, AnimeModel>()
		snapshot.appendSections([.main])
		snapshot.appendItems(animes)
		dataSource.apply(snapshot, animatingDifferences: true)
	}
}

extension AnimeCollectionVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		performQuery(with: searchText)
	}
}

extension AnimeCollectionVC: IAnimeCollectionVC {
	
}
