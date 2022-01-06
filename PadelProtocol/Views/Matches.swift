//
//  Matches.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2022-01-05.
//

import SwiftUI

func default_matches() -> [Match] {
	let match1 = Match(team_1_1: "Olsson", team_1_2: "Treutiger", team_2_1: "Lindblad", team_2_2: "Rabun", home: .team1)

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

struct Matches: View {

	@State var matches: [Match]

	init(matches: [Match] = []) {
		self.matches = matches
	}

	func get_matches() {
		//DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
			self.matches = default_matches()
		//})
	}

	func description(for teams: [Team: [String]]) -> String {
		let team_1: [String] = teams[.team1]!
		let team_2: [String] = teams[.team2]!
		return "\(team_1[0]), \(team_1[1]) vs. \(team_2[0]), \(team_2[1])"
	}

	func description(for score: (Int, Int)) -> String {
		return "(\(score.0) - \(score.1))"
	}

    var body: some View {
		NavigationView {
		VStack {
			List {
				ForEach(self.matches, id: \.uuid) { match in
					HStack {
						VStack(alignment: .leading) {
							Text(description(for: match.get_teams()))
								.font(.headline)
							Spacer()
							Text(description(for: match.set_score()))
								.font(.caption)
						}
						Spacer()
						Text("\(match.is_over() ? "Slut" : "Pågående")")
					}.padding()
				}
			}
		}
		}.onAppear {
			get_matches()
		}
     }
}

struct Matches_Previews: PreviewProvider {
    static var previews: some View {
        Matches()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
