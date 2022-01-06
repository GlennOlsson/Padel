//
//  Matches.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2022-01-05.
//

import SwiftUI

struct Matches: View {

	@ObservedObject var state: AppState

	func description(for teams: [Team: [String]]) -> String {
		let team_1: [String] = teams[.team1]!
		let team_2: [String] = teams[.team2]!
		return "\(team_1[0]), \(team_1[1]) vs. \(team_2[0]), \(team_2[1])"
	}

    var body: some View {
		NavigationView {
		VStack {
			List {
				ForEach(self.state.matches) { match in
					NavigationLink(destination: Sets(match: match)){
						HStack {
							VStack(alignment: .leading) {
								Text(description(for: match.get_teams()))
									.font(.headline)
								Spacer()
								Text("(\(tuple_desc(match.set_score())))")
									.font(.caption)
							}
							Spacer()
							Text("\(match.is_over() ? "Slut" : "Pågående")")
						}.padding()
					}
				}
			}
		}
		}.onAppear {
			state.fetch_matches()
		}
     }
}

struct Matches_Previews: PreviewProvider {
    static var previews: some View {
        Matches(state: AppState())
.previewInterfaceOrientation(.landscapeLeft)
    }
}
