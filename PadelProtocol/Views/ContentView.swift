//
//  ContentView.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		VStack {
			Scoreboard()
				.padding([.trailing, .leading])
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.previewInterfaceOrientation(.landscapeLeft)
    }
}
