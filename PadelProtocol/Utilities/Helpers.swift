//
//  Helpers.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2022-01-05.
//

import Foundation

func tuple_desc<T>(_ t: (T, T), delim: String = "-") -> String {
	return "\(t.0) \(delim) \(t.1)"
}
