//
//  ThreadSafeArray.swift
//  ThreadSafeArray
//
//  Created by Александр Фомин on 06.11.2021.
//

import Foundation

public class ThreadSafeArray <T : Equatable> {
	private var items = [T]()
	private let isolationQueue = DispatchQueue(label: "ThreadSafeArray queue",
											   attributes: .concurrent)
	
	public init (items: [T] = [T]()) {
		isolationQueue.async(flags: .barrier) {
			self.items = items
		}
	}
	
	public var isEmpty: Bool {
		isolationQueue.sync {
			self.items.count == 0
		}
	}
	
	public var count: Int {
		isolationQueue.sync {
			self.items.count
		}
	}
	
	public func append (_ item: T) {
		isolationQueue.async(flags: .barrier) {
			self.items.append(item)
		}
	}
	
	public func remove (at index: Int) {
		if index >= 0 && index < self.count {
			isolationQueue.async(flags: .barrier) {
				self.items.remove(at: index)
			}
		}
		else {
			print("Выход за границы массива при удалении")
		}
	}
	
	/*
	 *	Если делать защиту от выхода за границу здесь, то тогда у нас будет возвращаться T?
	 *	Иначе я не придумал что можно было бы сделать.
	 * 	Но можно с ходу сделать защиту для set, просто обернув его в if с проверкой на index
	*/
	public subscript(index: Int) -> T {
		get {
			isolationQueue.sync {
				self.items[index]
			}
		}
		set {
			if index >= 0 && index < self.count {
				isolationQueue.async(flags: .barrier) {
					self.items[index] = newValue
				}
			}
			else {
				print("Выход за границы массива при замене элемента")
			}
		}
	}
	
	public func contains(_ element: T) -> Bool {
		isolationQueue.sync {
			self.items.contains(element)
		}
	}
}
