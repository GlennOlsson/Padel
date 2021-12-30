//
//  PadelProtocolApp.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

@main
struct PadelProtocolApp: App {
    var body: some Scene {
        WindowGroup {
			ContentView(game: Game(is_golden_ball: false))
        }
    }
}
