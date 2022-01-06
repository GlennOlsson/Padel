//
//  PadelProtocolApp.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

@main
struct PadelProtocolApp: App {

	@ObservedObject var set: Set

	init() {
		let match = Match(team_1_1: "Lindblad", team_1_2: "Rabun", team_2_1: "Olsson", team_2_2: "Treutiger", home: .team2)
		set = match.current_set()
	}

    var body: some Scene {
        WindowGroup {
			Matches()
//			ContentView(game: set.current_game())
//				.environmentObject(set)
        }
    }
}
