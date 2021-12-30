//
//  Court.swift
//  PadelProtocol
//
//  Created by Glenn Olsson on 2021-12-27.
//

import SwiftUI

struct Court: View {

	let court_width: CGFloat = 500;
	let court_height: CGFloat = 500 * 0.5;

	@EnvironmentObject var game: Game

    var body: some View {

		let court_arrangement = game.court()
		let left_side: [String] = court_arrangement[.left]!
		let right_side: [String] = court_arrangement[.right]!

		return HStack {
			HStack {
				VStack {
					NameTag(name: left_side[0], is_serving: game.serving_side == .left && game.server() == 0)

					Spacer()

					NameTag(name: left_side[1], is_serving: game.serving_side == .left && game.server() == 1)
				}.padding()
				Spacer()
			}.frame(width: self.court_width/2)

			Rectangle()
			//For some reason expands beyond frame when = court_height
				.frame(width: 1, height: court_height * 0.99)
				.background(Color.black)


			HStack {
				Spacer()
				VStack {
					NameTag(name: right_side[0], is_serving: game.serving_side == .right && game.server() == 0)

					Spacer()

					NameTag(name: right_side[1], is_serving: game.serving_side == .right && game.server() == 1)
				}.padding()
			}.frame(width: self.court_width/2)
		}
		.frame(height: court_height)
		.background(Color.white)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 1)
		)
    }
}

struct NameTag: View {
	let name: String
	let is_serving: Bool

	init(name: String, is_serving: Bool = false) {
		self.name = name
		self.is_serving = is_serving
	}

	var body: some View {
		HStack {
			if is_serving {
				Text("🎾")
			}
			HStack {
				Text(name)
					.padding(10)
			}
			.background(Color.white)
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.black, lineWidth: 1)
			)
		}
	}
}

struct Court_Previews: PreviewProvider {
    static var previews: some View {
        Court()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
