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
		let sets: [Set] = match.all_sets()

		return List {
			ForEach(0..<sets.count) { i in
				Section("Set \(i+1) \t \(tuple_desc(sets[i].game_score()))") {
					
					ForEach(sets[i].all_games()) { game in
						GameRow(game: game)
					}
				}
			}
		}.navigationBarTitle(description(for: match.get_teams()))
    }
}

fileprivate struct GameRow: View {
	@ObservedObject var game: Game

	var body: some View {
		let is_over = game.is_over()

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
