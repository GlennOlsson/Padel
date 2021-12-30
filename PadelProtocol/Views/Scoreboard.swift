//
//  Scoreboard.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

///Pad to be of set size characters. end signifies if the pass should be at end of string (else at beginning)
func padd_score(_ str: String, end: Bool) -> String {
	let padd_size = 3
	let append_str = String(repeating: " ", count: padd_size - str.count)
	return end ? str.appending(append_str) : append_str.appending(str)
}

struct Scoreboard: View {

	@EnvironmentObject var set: Set
	@EnvironmentObject var game: Game

    var body: some View {

		let score = game.score()

		let t1_score = padd_score(score.0, end: false)
		let t2_score = padd_score(score.1, end: true)

		let is_game_over = game.is_over()

		let (t1_game_score, t2_game_score) = set.game_score()

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

					Text("(\(t1_game_score) - \(t2_game_score))")
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

//struct Scoreboard_Previews: PreviewProvider {
//    static var previews: some View {
//        Scoreboard()
//			.previewInterfaceOrientation(.landscapeLeft)
//    }
//}
