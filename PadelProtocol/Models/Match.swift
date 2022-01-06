//
//  Match.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2022-01-05.
//

import Foundation
import SwiftUI

class Match: ObservableObject, Identifiable, Hashable {
	static func == (lhs: Match, rhs: Match) -> Bool {
		return lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

	@Published var sets: [Set] = []

	@Published private var teams: [Team: [String]]

	var id: UUID = .init()

	private let home: Team

	init(team_1_1: String, team_1_2: String, team_2_1: String, team_2_2: String, home: Team) {
		self.teams = [.team1: [team_1_1, team_1_2], .team2: [team_2_1, team_2_2]]
		self.home = home
		new_set()
	}

	func get_teams() -> [Team: [String]] {
		return self.teams
	}

	/// Get "description" of team, i.e. comma separated list of the team members
	func get(team: Team) -> String {
		let members = self.teams[team]!
		return "\(members[0]), \(members[1])"
	}

	func new_set() {
		// If team1 is home and is start of an odd game, set team1 at home pos == left
		let team1_at: CourtSide = self.home == .team1 && sets.count % 2 == 0 ? .left : .right
		let set = Set(match: self, teams: teams, team1_at: team1_at)

		sets.append(set)
	}
	
	func current_set() -> Set {
		return sets.last!
	}

	///Return (team1score, team2score) in that order, for previous sets
	func set_score() -> (Int, Int) {
		var (t1_s, t2_s) = (0, 0)
		for s in sets {
			switch s.winning_team() {
			case .team1:
				t1_s += 1
				break
			case .team2:
				t2_s += 1
				break
			default:
				print("Set not over")
			}
		}

		return (t1_s, t2_s)
	}

	func is_over() -> Bool {
		let score = set_score()
		//TODO: Introduce Marginal
		return score.0 == 2 || score.1 == 2
	}
}
