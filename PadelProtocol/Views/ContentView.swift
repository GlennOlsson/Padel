//
//  ContentView.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct ContentView: View {

	@EnvironmentObject var set: Set

    var body: some View {
		let game = set.current_game()

		VStack {
			Court()

			Scoreboard()
				.padding([.trailing, .leading])
		}.environmentObject(game)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.previewInterfaceOrientation(.landscapeLeft)
    }
}
