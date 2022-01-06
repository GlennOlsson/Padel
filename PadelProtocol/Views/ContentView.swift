//
//  ContentView.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct ContentView: View {

	@EnvironmentObject var set: Set
	@ObservedObject var game: Game

    var body: some View {
		VStack {
			Court()

			if game.is_over() {
				Button("Nytt Gem") {
					set.new_game()
				}
			}

			Scoreboard()
				.padding([.trailing, .leading])
		}.environmentObject(game)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//		ContentView()
//			.previewInterfaceOrientation(.landscapeLeft)
//    }
//}
