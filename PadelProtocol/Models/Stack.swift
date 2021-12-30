//
//  Stack.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-29.
//

import Foundation

class Stack<T> {

	private var arr: [T] = []

	init() {
		arr = []
		//Reserve capacity to keep all points
		arr.reserveCapacity(20)
	}

	func push(_ elem: T) {
		arr.append(elem)
	}

	func pop() -> T? {
		return arr.popLast()
	}

	func removeLast() {
		arr.removeLast()
	}

	func peek() -> T? {
		return arr.last
	}

	func size() -> Int {
		return arr.count
	}
}
