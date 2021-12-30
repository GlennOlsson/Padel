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
	//Teams value is index in points array. Index 0 in tuple is for team1
	private let scorings: Stack<(Int, Int)>

	@Published private var winner_team: Team?

	private let is_golden_ball: Bool

	let serving_side: CourtSide
	/// Each courtside has a list of the corresponding players in order from top to bottom
	@Published private var court_arrangement: [CourtSide: [String]]

	init(court_arrangement: [CourtSide: [String]], serving_side: CourtSide, is_golden_ball: Bool = true) {
		self.scorings = .init()
		self.scorings.push((0, 0))

		self.court_arrangement = court_arrangement
		self.serving_side = serving_side
		self.is_golden_ball = is_golden_ball
	}

	private func flip_serving_pos() {
		let serving_side_arrangement = court_arrangement[serving_side]!
		court_arrangement[serving_side] = serving_side_arrangement.reversed()
	}

	func save_score(for team: Team, team_score: Int, other_team_score: Int) {
		if team == .team1 {
			scorings.push((team_score, other_team_score))
		} else {
			scorings.push((other_team_score, team_score))
		}
	}

	func increase_points(for team: Team) {
		if winner_team != nil {
			return
		}

		let current_score: (Int, Int) = scorings.peek()!

		let current_team_score = team == .team1 ? current_score.0 : current_score.1
		let new_score: Int = current_team_score + 1

		let other_score: Int = team.other() == .team1 ? current_score.0 : current_score.1

		// Add one to teams score
		// If score is not outside of points range
		if new_score <= max_index {
			save_score(for: team, team_score: new_score, other_team_score: other_score)
			flip_serving_pos()
		} else if new_score == max_index + 1 { // If new score would be ADV/game over
			if is_golden_ball && other_score == max_index + 1 {
				// if golden ball and other score == ADV, set both to 40
				save_score(for: team, team_score: max_index, other_team_score: max_index)
				flip_serving_pos()
			} else if is_golden_ball && other_score == max_index {
				// If golden ball and other score == 40, set to ADV for team
				save_score(for: team, team_score: new_score, other_team_score: max_index)
				flip_serving_pos()
			} else {
				winner_team = team
			}
		} else if new_score == max_index + 2 { // Game over from ADV
			winner_team = team
		}
	}

	func undo_score() {
		guard scorings.size() > 1 else {
			//No element == no scores
			return
		}
		// Don't decrease score if game was over
		if winner_team != nil {
			winner_team = nil
			return
		}
		scorings.removeLast()
		flip_serving_pos()
	}

	func score() -> (String, String) {
		let (team1_i, team2_i) = scorings.peek()!
		return (points[team1_i], points[team2_i])
	}

	///Get the current court arrangement
	func court() -> [CourtSide: [String]] {
		return court_arrangement
	}

	///Returns index of serving team that the current server is at
	func server() -> Int {
		// - 1 because starts at 1 where it should be index 0
		return (scorings.size() - 1) % 2
	}

	///If is beginning of game
	func is_beginning() -> Bool {
		return self.scorings.size() == 1
	}

	/// If game is over
	func is_over() -> Bool {
		return winner_team != nil
	}

	func winning_team() -> Team? {
		return winner_team
	}
}
