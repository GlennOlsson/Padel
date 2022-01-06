//
//  Sets.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2022-01-05.
//

import SwiftUI

struct Sets: View {

	let match: Match

	func description(for score: (String, String)) -> String {
		return "\(score.0) - \(score.1)"
	}

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
					
					ForEach(sets[i].all_games(), id: \.uuid) { game in
						HStack {
							Text("\(description(for: game.score()))")
							
							Spacer()
							
							Text("\(game.is_over() ? "✅" : "⌛️")")
						}
					}
				}
			}
		}.navigationBarTitle(description(for: match.get_teams()))
    }
}

struct Sets_Previews: PreviewProvider {
    static var previews: some View {
        Sets(match: default_matches()[0])
.previewInterfaceOrientation(.landscapeLeft)
    }
}
