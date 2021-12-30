//
//  Set.swift
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

enum CourtSide: Int {
	case left = 0
	case right = 1

	func other() -> CourtSide {
		return self == .left ? .right : .left
	}
}

class Set: ObservableObject {
	@Published private var games: [Game] = []

	private var teams: [Team: [String]]

	init(team_1_1: String, team_1_2: String, team_2_1: String, team_2_2: String, home: Team) {
		self.teams = [.team1: [team_1_1, team_1_2], .team2: [team_2_1, team_2_2]]

		let court_arrangement = arrangement(for: .left)
		let first_game = Game(court_arrangement: court_arrangement, serving_side: .left)
		games.append(first_game)
	}

	private func arrangement(for team1_at: CourtSide) -> [CourtSide: [String]] {
		return [team1_at: teams[.team1]!, team1_at.other(): teams[.team2]!]
	}

	//there's always at least one came
	func current_game() -> Game {
		return games.last!
	}

	///Return (team1score, team2score) in that order, for previous games
	func game_score() -> (Int, Int) {
		var team1_s = 0
		var team2_s = 0
		for game in games {
			switch game.winning_team() {
			case .team1:
				team1_s += 1
				break
			case .team2:
				team2_s += 1
				break
			default:
				print("Game not over")
			}
		}
		return (team1_s, team2_s)
	}
}
