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
	
	private let appRouter: IAppRouter
	private let animeCollectionView: IAnimeCollectionView
	private let animesModel = AnimesModel()
	private var dataSource: UICollectionViewDiffableDataSource<Section, AnimeModel>!
	
	init() {
		self.appRouter = AppRouter()
		self.animeCollectionView = AnimeCollectionView()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "Каталог аниме"
		self.navigationItem.backButtonDisplayMode = .minimal
		self.view = self.animeCollectionView
		self.animeCollectionView.didLoad()
		
		self.animeCollectionView.getSearchBar().delegate = self
		self.animeCollectionView.getAnimesCollectionView().delegate = self
			
		self.configureDataSource()
		self.performQuery(with: nil)
	}
	
	override func loadView() {
		super.loadView()
		self.animeCollectionView.loadView(controller: self)
	}
}

extension AnimeCollectionVC: IAnimeCollectionVC {
	
}

extension AnimeCollectionVC: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.animeCollectionView.getAnimesCollectionView().deselectItem(at: indexPath, animated: true)
		guard let anime = dataSource.itemIdentifier(for: indexPath) else {
			return
		}
		
		self.createAnimePage(anime: anime)
	}
}

extension AnimeCollectionVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.performQuery(with: searchText)
	}
}

private extension AnimeCollectionVC {
	func createAnimePage(anime: AnimeModel) {
		let animePageVC = AnimePageAssembly.build(animeIdentifier: anime.identifier)
		self.appRouter.setController(controller: self)
		self.appRouter.setTargerController(controller: animePageVC)
		self.appRouter.next()
	}
	
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
