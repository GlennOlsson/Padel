//
//  Game.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-29.
//

import Foundation

let points = ["0", "15", "30", "40", "ADV"]
// Max index before it is ADV, i.e. when it's 40
let max_index = 3

class Game: ObservableObject {
	//Teams value is index in points array
	@Published private var team_points: [Team: Int] = [.team1: 0, .team2: 0]

	private let scorings: Stack<Team> = .init()

	@Published private var game_over: Bool = false

	private let is_golden_ball: Bool

	init(is_golden_ball: Bool = true) {
		self.is_golden_ball = is_golden_ball
	}

	func increase_points(for team: Team) {
		if game_over == true {
			return
		}
		scorings.push(team)

		let new_score: Int = team_points[team]! + 1
		let other_score: Int = team_points[team.other()]!

		// Add one to teams score
		// If score is not outside of points range
		if new_score <= max_index {
			team_points[team]! = new_score
		} else if new_score == max_index + 1 { // If new score would be ADV/game over
			// if golden ball and other score == 40p/ADV)
			if is_golden_ball && other_score >= max_index {
				team_points[team] = new_score
				team_points[team.other()] = max_index
			} else {
				game_over = true
			}
		} else if new_score == max_index + 2 { // Game over from ADV
			game_over = true
		}
	}

	func undo_score() {
		guard let team = scorings.pop() else {
			//No element == no scores
			return
		}
		// Don't decrease score if game was over
		if game_over == true {
			game_over = false
			return
		}
		// Subtract one from teams score
		team_points[team]! -= 1
	}

	func score() -> (String, String) {
		let (team1_i, team2_i) = (team_points[.team1]!, team_points[.team2]!)
		return (points[team1_i], points[team2_i])
	}

	///If is beginning of game
	func is_beginning() -> Bool {
		return team_points[.team1] == 0 && team_points[.team2] == 0
	}

	/// If game is over
	func is_over() -> Bool {
		return game_over
	}
}
