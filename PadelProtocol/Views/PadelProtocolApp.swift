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
		set = Set(team_1_1: "Lindblad", team_1_2: "Rabun", team_2_1: "Olsson", team_2_2: "Treutiger", home: .team2)
	}

    var body: some Scene {
        WindowGroup {
			ContentView(game: set.current_game())
				.environmentObject(set)
        }
    }
}
