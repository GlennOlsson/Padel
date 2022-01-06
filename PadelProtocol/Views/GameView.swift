//
//  GameView.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct GameView: View {

	@ObservedObject var game: Game

	@Environment(\.dismiss) var dismiss

    var body: some View {
		VStack {
			Court()

			Scoreboard(game: game)
				.padding([.trailing, .leading])

			if game.is_over() {
				Button("Avsluta gem") {
					game.end()
					dismiss()
				}
			}
		}.environmentObject(game)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//		ContentView()
//			.previewInterfaceOrientation(.landscapeLeft)
//    }
//}
