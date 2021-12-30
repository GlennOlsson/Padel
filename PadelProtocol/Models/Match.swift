//
//  Match.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-29.
//

import Foundation

enum Team {
	case team1, team2

	func other() -> Team {
		return self == .team1 ? .team2 : .team1
	}
}

class Set {
	var games: [Game] = []
}
