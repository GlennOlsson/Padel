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

	@Published private var teams: [Team: [String]]

	private var team1_at: CourtSide

	init(teams: [Team: [String]], team1_at: CourtSide) {
		self.teams = teams

		self.team1_at = team1_at

		let court_arrangement = arrangement()
		let first_game = Game(court_arrangement: court_arrangement, serving_side: self.team1_at)
		games.append(first_game)
	}

	private func arrangement() -> [CourtSide: [String]] {
		return [team1_at: teams[.team1]!, team1_at.other(): teams[.team2]!]
	}

	func all_games() -> [Game] {
		return games
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

	func new_game() {
		guard !is_over() else {
			// TODO: Throw exception? Signal error somehow
			return
		}
		//Need to:
		// - Swap order of new serving team so correct person is serving
		// - Change side of teams if is end of an odd game
		// - Change serving team to other team

		let prev_game = current_game()

		let prev_serving_side = prev_game.serving_side

		// Swap places of non-serving team (who will now serve)
		let non_serving_team: Team = team1_at == prev_serving_side ? .team1 : .team2
		teams[non_serving_team] = teams[non_serving_team]!.reversed()

		/// If the last ended game was odd
		let was_odd_game = games.count % 2 == 1

		// If end of even game, change serving side
		// At end of odd games, teams switch side to serving side stays the same
		let new_serving_side = !was_odd_game ? prev_serving_side.other() : prev_serving_side

		// If was odd game, change side of team1
		team1_at = was_odd_game ? team1_at.other() : team1_at

		let game = Game(court_arrangement: arrangement(), serving_side: new_serving_side)
		games.append(game)
	}

	func is_over() -> Bool {
		let (t1_score, t2_score) = game_score()
		//TODO: Improve this logic. Tie breaker? Marginal of games
		return t1_score == 6 || t2_score == 6
	}

	func winning_team() -> Team? {
		guard is_over() else {
			return nil
		}
		let (t1_score, _) = game_score()
		// TODO: Fix when is_over logic is improved
		return t1_score == 6 ? .team1 : .team2
	}
}
