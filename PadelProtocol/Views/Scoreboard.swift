//
//  Scoreboard.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct Scoreboard: View {
    var body: some View {
		HStack {
			PointCounter(color: Color.blue)

			Spacer(minLength: 50)

			VStack(alignment: .trailing) {
				Text("Lindblad")
				Text("Rabun")
			}

			Spacer(minLength: 50)

			VStack(alignment: .center) {
				Text("15   -   0")
					.font(.largeTitle)

				Text("(1 - 0)")
					.font(.title2)

				Button("Ångra") {
					print("")
				}.padding()
			}

			Spacer(minLength: 50)

			VStack(alignment: .leading)  {
				Text("Olsson")
				Text("Treutiger")
			}

			Spacer(minLength: 50)

			PointCounter(color: Color.red)
		}
    }
}

struct Scoreboard_Previews: PreviewProvider {
    static var previews: some View {
        Scoreboard()
			.previewInterfaceOrientation(.landscapeLeft)
    }
}
