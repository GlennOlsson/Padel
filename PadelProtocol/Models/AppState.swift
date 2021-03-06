//
//  AppState.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2022-01-06.
//

import Foundation

func default_matches() -> [Match] {
	let match1 = Match(team_1_1: "Olsson", team_1_2: "Treutiger", team_2_1: "Lindblad", team_2_2: "Rabun", home: .team1)

	let m1_s1 = match1.current_set()

	for _ in 0..<6 {
		// Make 1 - 0
		let game = m1_s1.current_game()

		game.increase_points(for: .team1) // 15 - 0
		game.increase_points(for: .team1) // 30 - 0
		game.increase_points(for: .team1) // 40 - 0
		game.increase_points(for: .team2) // 40 - 15
		game.increase_points(for: .team1) // OVER 40 - 15

		game.end()

		m1_s1.new_game()
	}

	match1.new_set()

	for _ in 0..<3 {
		// Make 1 - 0
		let game = match1.current_set().current_game()

		game.increase_points(for: .team1) // 15 - 0
		game.increase_points(for: .team1) // 30 - 0
		game.increase_points(for: .team2) // 30 - 15
		game.increase_points(for: .team2) // 30 - 30
		game.increase_points(for: .team1) // 40 - 15
		game.increase_points(for: .team1) // OVER 40 - 15

		game.end()

		match1.current_set().new_game()
	}

	match1.current_set().current_game().increase_points(for: .team1) // 15 - 0
	match1.current_set().current_game().increase_points(for: .team1) // 30 - 0
	match1.current_set().current_game().increase_points(for: .team2) // 30 - 15

	let match2 = Match(team_1_1: "Olsson", team_1_2: "Treutiger", team_2_1: "Nadal", team_2_2: "Borg", home: .team1)

	let match3 = Match(team_1_1: "Andersson", team_1_2: "Petterson", team_2_1: "Lundström", team_2_2: "Jag", home: .team2)

	let match4 = Match(team_1_1: "Kasper", team_1_2: "Jesper", team_2_1: "Och", team_2_2: "Jonatan", home: .team2)

	let match5 = Match(team_1_1: "Skorpan", team_1_2: "Jonatan", team_2_1: "Katla", team_2_2: "Tengil", home: .team1)


	let matches: [Match] = [
		match1,
		match2,
		match3,
		match4,
		match5
	]

	return matches
}

class AppState: ObservableObject {
	@Published var matches: [Match] = []

	func fetch_matches() {
		//DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
			self.matches = default_matches()
		//})
	}
}
