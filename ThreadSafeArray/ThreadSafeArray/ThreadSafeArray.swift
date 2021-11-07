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
		self.items.isEmpty
	}
	
	public var count: Int {
		self.items.count
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
	
	public subscript(index: Int) -> T {
		get {
			self.items[index]
		}
		set {
			isolationQueue.async(flags: .barrier) {
				self.items[index] = newValue
			}
		}
	}
	
	public func contains(_ element: T) -> Bool {
		self.items.contains(element)
	}
}
