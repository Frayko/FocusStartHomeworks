//
//  Observable.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 28.11.2021.
//

class Observable<T> {
	var data: T {
		didSet {
			self.notify?(self.data)
		}
	}

	private var notify: ((T) -> Void)?

	init(_ data: T) {
		self.data = data
	}

	func setNotify(notify: @escaping ((T) -> Void)) {
		self.notify = notify
		self.notify?(self.data)
	}
}
