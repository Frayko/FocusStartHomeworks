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
	public init () {}
	
	public init (with content: T...) {
		isolationQueue.async(flags: .barrier) {
			self.items.append(contentsOf: content)
		}
	}
	
	public var isEmpty: Bool {
		isolationQueue.sync {
			self.items.isEmpty
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
		isolationQueue.async(flags: .barrier) {
			if index >= 0 && index < self.count {
				self.items.remove(at: index)
			}
			else {
				print("Выход за границы массива при удалении")
			}
		}
	}
	
	public func contains(_ element: T) -> Bool {
		isolationQueue.sync {
			self.items.contains(element)
		}
	}
	
	public func getItems() -> [T] {
		isolationQueue.sync {
			self.items
		}
	}
}

public class ThreadSafeArrayIterator<T>: IteratorProtocol {
	private var items = [T]()
	private var currentIndex: Int = -1
	private let isolationQueue = DispatchQueue(label: "ThreadSafeArray queue",
											   attributes: .concurrent)
	
	public init(with items: [T]) {
		isolationQueue.async(flags: .barrier) {
			self.items = items
		}
	}

	public func next() -> T? {
		isolationQueue.sync {
			self.currentIndex += 1
			guard currentIndex < self.items.count else { return nil }
			return items[currentIndex]
		}
	}
}

extension ThreadSafeArray: Sequence {
	public func makeIterator() -> ThreadSafeArrayIterator<T> {
		ThreadSafeArrayIterator<T>(with: getItems())
	}
}

extension ThreadSafeArray: CustomStringConvertible {
	public var description: String {
		isolationQueue.sync {
			"[ " + self.items.map { String(describing: $0) }.joined(separator: ", ") + " ]"
		}
	}
}

extension ThreadSafeArray: Collection {
	public var startIndex: Int {
		isolationQueue.sync {
			self.items.startIndex
		}
	}

	public var endIndex: Int {
		isolationQueue.sync {
			self.items.endIndex
		}
	}

	public subscript(index: Int) -> T {
		get {
			isolationQueue.sync {
				self.items[index]
			}
		}
		set {
			isolationQueue.async(flags: .barrier) {
				self.items[index] = newValue
			}
		}
	}

	public func index(after i: Int) -> Int {
		isolationQueue.sync {
			i + 1
		}
	}
}
