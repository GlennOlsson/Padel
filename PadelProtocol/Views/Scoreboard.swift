//
//  Scoreboard.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

///Pad to be of set size characters
func padd_score(_ str: String) -> String {
	let padd_size = 3
	let append_str = String(repeating: " ", count: padd_size - str.count)
	return str.appending(append_str)
}

struct Scoreboard: View {

	@EnvironmentObject var game: Game

    var body: some View {

		let score = game.score()

		let t1_score = padd_score(score.0)
		let t2_score = padd_score(score.1)

		let is_game_over = game.is_over()

		return HStack {
			PointCounter(color: Color.blue) {
				game.increase_points(for: .team1)
			}.disabled(is_game_over)

			HStack {
				Spacer(minLength: 50)

				VStack(alignment: .trailing) {
					Text("Lindblad")
					Text("Rabun")
				}

				Spacer(minLength: 50)

				VStack(alignment: .center) {
					Text("\(t1_score) - \(t2_score)")
						.font(.largeTitle.monospaced())

					Text("(1 - 0)")
						.font(.title2.monospaced())

					Button("Ångra") {
						game.undo_score()
					}.padding()
				}

				Spacer(minLength: 50)

				VStack(alignment: .leading)  {
					Text("Olsson")
					Text("Treutiger")
				}

				Spacer(minLength: 50)
			}.fixedSize()

			PointCounter(color: Color.red) {
				game.increase_points(for: .team2)
			}.disabled(is_game_over)
		}
    }
}

struct Scoreboard_Previews: PreviewProvider {
    static var previews: some View {
        Scoreboard()
			.previewInterfaceOrientation(.landscapeLeft)
    }
}
