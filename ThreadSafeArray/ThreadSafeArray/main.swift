//
//  main.swift
//  ThreadSafeArray
//
//  Created by Александр Фомин on 06.11.2021.
//

import Foundation

let queue = DispatchQueue(label: "My Queue",
							attributes: .concurrent)
let queueTestGroup = DispatchGroup()
let threadSafeArray = ThreadSafeArray<Int>()

func task() {
	for number in 0...1000 {
		threadSafeArray.append(number)
	}
}

queueTestGroup.enter()
queue.async {
	task()
	queueTestGroup.leave()
}

queueTestGroup.enter()
queue.async {
	task()
	queueTestGroup.leave()
}

queueTestGroup.wait()
print(threadSafeArray.count)
