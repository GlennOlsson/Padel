//
//  PointCounter.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct PointCounter: View {

	let color: Color

    var body: some View {
		ZStack {
			Circle()
				.foregroundColor(color)
			Text("+")
				.foregroundColor(Color.white)
				.font(Font.system(size: 100))
		}
		.minimumScaleFactor(0.01)
    }
}

struct PointCounter_Previews: PreviewProvider {
    static var previews: some View {
		PointCounter(color: Color.blue)
    }
}
