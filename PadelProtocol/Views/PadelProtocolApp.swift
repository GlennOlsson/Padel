//
//  PadelProtocolApp.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

@main
struct PadelProtocolApp: App {

	@ObservedObject var state: AppState

	init() {
		self.state = AppState()
	}

    var body: some Scene {
        WindowGroup {
			Matches(state: self.state)
//			ContentView(game: set.current_game())
//				.environmentObject(set)
        }
    }
}
