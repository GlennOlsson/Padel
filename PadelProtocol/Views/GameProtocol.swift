//
//  GameProtocol.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2022-01-05.
//

import SwiftUI

struct GameProtocol: View {

	@ObservedObject var game: Game

    var body: some View {
		let scorings = game.get_scorings()

		return VStack {
			Court()

			HStack {
				VStack(alignment: .leading) {
					Text("\(game.get(team: .team1))")

					Text("\(game.get(team: .team2))")
				}.padding()
					.font(.title)

				HStack {
					ForEach(0..<scorings.count) { i in
						VStack {
							Text(scorings[i].0)

							Text(scorings[i].1)
						}
					}
				}
				.font(.title2)
			}
		}.environmentObject(game)
    }
}

struct GameProtocol_Previews: PreviewProvider {
    static var previews: some View {
		GameProtocol(game: default_matches()[0].all_sets()[0].all_games()[3])
.previewInterfaceOrientation(.landscapeLeft)
    }
}
