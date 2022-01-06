//
//  Sets.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2022-01-05.
//

import SwiftUI

struct Sets: View {

	@ObservedObject var match: Match

	func description(for teams: [Team: [String]]) -> String {
		let team_1: [String] = teams[.team1]!
		let team_2: [String] = teams[.team2]!
		return "\(team_1[0]), \(team_1[1]) vs. \(team_2[0]), \(team_2[1])"
	}

	var body: some View {

		let sets: [Set] = match.sets

		return List {
			ForEach(sets.indices) { i in
				Section("Set \(i+1) \t \(tuple_desc(sets[i].game_score()))") {

					ForEach(sets[i].all_games()) { game in
						GameRow(game: game)
					}
				}
			}
			if let current_set = sets.last, current_set.current_game().is_ended && !current_set.is_over() {
				Button("Nytt gem") {
					sets.last!.new_game()
				}
			}
		}.navigationBarTitle(description(for: match.get_teams()))
    }
}

fileprivate struct GamesList: View {
	@ObservedObject var set: Set
	let i: Int

	var body: some View {
		Section("Set \(i+1) \t \(tuple_desc(set.game_score()))") {

			ForEach(set.all_games()) { game in
				GameRow(game: game)
			}
		}
	}
}

fileprivate struct GameRow: View {
	@ObservedObject var game: Game

	var body: some View {
		let is_over = game.is_ended

		let nav_dest: AnyView = is_over ? AnyView(GameProtocol(game: game)) : AnyView(GameView(game: game))

		return NavigationLink(destination: nav_dest) {
			HStack {
				Text("\(tuple_desc(game.score()))")

				Spacer()

				Text("\(is_over ? "✅" : "⌛️")")
			}
		}
	}
}

struct Sets_Previews: PreviewProvider {
    static var previews: some View {
        Sets(match: default_matches()[0])
.previewInterfaceOrientation(.landscapeLeft)
    }
}
