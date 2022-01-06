//
//  Stack.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-29.
//

import Foundation

class Stack<T>: Sequence {

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

	func raw() -> [T] {
		return arr
	}

	func makeIterator() -> StackIterator<T> {
		return .init(self)
	}
}

class StackIterator<T>: IteratorProtocol {
	typealias Element = T

	let stack: Stack<T>
	var curr_i = 0

	init(_ s: Stack<T>) {
		self.stack = s
	}

	func next() -> T? {
		guard curr_i < stack.raw().count else {
			return nil
		}
		let elem = stack.raw()[curr_i]
		curr_i += 1

		return elem
	}
}
